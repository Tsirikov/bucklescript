--[['use strict';]]

Caml_builtin_exceptions = require "./caml_builtin_exceptions";

/***********************************************************************/
/*                                                                     */
/*                           Objective Caml                            */
/*                                                                     */
/*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         */
/*                                                                     */
/*  Copyright 1996 Institut National de Recherche en Informatique et   */
/*  en Automatique.  All rights reserved.  This file is distributed    */
/*  under the terms of the GNU Library General Public License, with    */
/*  the special exception on linking described in file ../LICENSE.     */
/*                                                                     */
/***********************************************************************/

/* $Id: lexing.c 6045 2004-01-01 16:42:43Z doligez $ */

/* The table-driven automaton for lexers generated by camllex. */

function caml_lex_array(s) {
    var l = s.length / 2;
    var a = new Array(l);
    // when s.charCodeAt(2 * i + 1 ) > 128 (0x80)
    // a[i] < 0  
    // for(var i = 0 ; i <= 0xffff; ++i) { if (i << 16 >> 16 !==i){console.log(i<<16>>16, 'vs',i)}}
    // 
    for (var i = 0; i < l; i++)
        a[i] = (s.charCodeAt(2 * i) | (s.charCodeAt(2 * i + 1) << 8)) << 16 >> 16;
    return a;
}
;

caml_lex_engine_aux = (function (tbl, start_state, lexbuf, exn){
    // Lexing.lexbuf
    var lex_buffer = 'lex_buffer';
    var lex_buffer_len = 'lex_buffer_len';
    var lex_start_pos = 'lex_start_pos';
    var lex_curr_pos = 'lex_curr_pos';
    var lex_last_pos = 'lex_last_pos';
    var lex_last_action = 'lex_last_action';
    var lex_eof_reached = 'lex_eof_reached';
    // Lexing.lex_tables
    var lex_base = 'lex_base';
    var lex_backtrk = 'lex_backtrk';
    var lex_default = 'lex_default';
    var lex_trans = 'lex_trans';
    var lex_check = 'lex_check';
    if (!tbl.processed) {
        tbl.lex_base = caml_lex_array(tbl[lex_base]);
        tbl.lex_backtrk = caml_lex_array(tbl[lex_backtrk]);
        tbl.lex_check = caml_lex_array(tbl[lex_check]);
        tbl.lex_trans = caml_lex_array(tbl[lex_trans]);
        tbl.lex_default = caml_lex_array(tbl[lex_default]);
        tbl.processed = true;
    }
    var c;
    var state = start_state;
    //var buffer = bytes_of_string(lexbuf[lex_buffer]);
    var buffer = lexbuf[lex_buffer];
    if (state >= 0) {
        /* First entry */
        lexbuf[lex_last_pos] = lexbuf[lex_start_pos] = lexbuf[lex_curr_pos];
        lexbuf[lex_last_action] = -1;
    }
    else {
        /* Reentry after refill */
        state = -state - 1;
    }
    for (;;) {
        /* Lookup base address or action number for current state */
        var base = tbl.lex_base[state];
        if (base < 0)
            return -base - 1;
        /* See if it's a backtrack point */
        var backtrk = tbl.lex_backtrk[state];
        if (backtrk >= 0) {
            lexbuf[lex_last_pos] = lexbuf[lex_curr_pos];
            lexbuf[lex_last_action] = backtrk;
        }
        /* See if we need a refill */
        if (lexbuf[lex_curr_pos] >= lexbuf[lex_buffer_len]) {
            if (lexbuf[lex_eof_reached] === 0)
                return -state - 1;
            else
                c = 256;
        }
        else {
            /* Read next input char */
            c = buffer[lexbuf[lex_curr_pos]];
            lexbuf[lex_curr_pos]++;
        }
        /* Determine next state */
        if (tbl.lex_check[base + c] === state) {
            state = tbl.lex_trans[base + c];
        }
        else {
            state = tbl.lex_default[state];
        }
        /* If no transition on this char, return to last backtrack point */
        if (state < 0) {
            lexbuf[lex_curr_pos] = lexbuf[lex_last_pos];
            if (lexbuf[lex_last_action] == -1)
                throw exn
            else
                return lexbuf[lex_last_action];
        }
        else {
            /* Erase the EOF condition only if the EOF pseudo-character was
             consumed by the automaton (i.e. there was no backtrack above)
             */
            if (c == 256)
                lexbuf[lex_eof_reached] = 0;
        }
    }
});

empty_token_lit = "lexing: empty token";

function caml_lex_engine(tbls, i, buf) do
  return caml_lex_engine_aux(tbls, i, buf, {
              Caml_builtin_exceptions.failure,
              empty_token_lit
            });
end end

/***********************************************/
/* New lexer engine, with memory of positions  */
/***********************************************/

/**
 * s -> Lexing.lex_tables.lex_code
 * mem -> Lexing.lexbuf.lex_mem (* int array *)
 */          
          
function caml_lex_run_mem(s, i, mem, curr_pos) {
    for (;;) {
        var dst = s.charCodeAt(i);
        i++;
        if (dst == 0xff)
            return;
        var src = s.charCodeAt(i);
        i++;
        if (src == 0xff)
            mem[dst] = curr_pos;
        else
            mem[dst] = mem[src];
    }
}


/**
 * s -> Lexing.lex_tables.lex_code
 * mem -> Lexing.lexbuf.lex_mem (* int array *)
 */
  
function caml_lex_run_tag(s, i, mem) {
    for (;;) {
        var dst = s.charCodeAt(i);
        i++;
        if (dst == 0xff)
            return;
        var src = s.charCodeAt(i);
        i++;
        if (src == 0xff)
            mem[dst] = -1;
        else
            mem[dst] = mem[src];
    }
}
;

caml_new_lex_engine_aux = (function (tbl, start_state, lexbuf, exn) {
    // Lexing.lexbuf
    var lex_buffer = 'lex_buffer';
    var lex_buffer_len = 'lex_buffer_len';
    var lex_start_pos = 'lex_start_pos';
    var lex_curr_pos = 'lex_curr_pos';
    var lex_last_pos = 'lex_last_pos';
    var lex_last_action = 'lex_last_action';
    var lex_eof_reached = 'lex_eof_reached';
    var lex_mem = 'lex_mem';
    // Lexing.lex_tables
    var lex_base = 'lex_base';
    var lex_backtrk = 'lex_backtrk';
    var lex_default = 'lex_default';
    var lex_trans = 'lex_trans';
    var lex_check = 'lex_check';
    var lex_base_code = 'lex_base_code';
    var lex_backtrk_code = 'lex_backtrk_code';
    var lex_default_code = 'lex_default_code';
    var lex_trans_code = 'lex_trans_code';
    var lex_check_code = 'lex_check_code';
    var lex_code = 'lex_code';
    if (!tbl.processed) {
        tbl.lex_base = caml_lex_array(tbl[lex_base]);
        tbl.lex_backtrk = caml_lex_array(tbl[lex_backtrk]);
        tbl.lex_check = caml_lex_array(tbl[lex_check]);
        tbl.lex_trans = caml_lex_array(tbl[lex_trans]);
        tbl.lex_default = caml_lex_array(tbl[lex_default]);
        tbl.lex_base_code = caml_lex_array(tbl[lex_base_code]);
        tbl.lex_backtrk_code = caml_lex_array(tbl[lex_backtrk_code]);
        tbl.lex_check_code = caml_lex_array(tbl[lex_check_code]);
        tbl.lex_trans_code = caml_lex_array(tbl[lex_trans_code]);
        tbl.lex_default_code = caml_lex_array(tbl[lex_default_code]);
        tbl.processed = true;
    }
    var c, state = start_state;
    //var buffer = caml_bytes_of_string(lexbuf[lex_buffer]);
    var buffer = lexbuf[lex_buffer];
    if (state >= 0) {
        /* First entry */
        lexbuf[lex_last_pos] = lexbuf[lex_start_pos] = lexbuf[lex_curr_pos];
        lexbuf[lex_last_action] = -1;
    }
    else {
        /* Reentry after refill */
        state = -state - 1;
    }
    for (;;) {
        /* Lookup base address or action number for current state */
        var base = tbl.lex_base[state];
        if (base < 0) {
            var pc_off = tbl.lex_base_code[state];
            caml_lex_run_tag(tbl.lex_code, pc_off, lexbuf[lex_mem]);
            return -base - 1;
        }
        /* See if it's a backtrack point */
        var backtrk = tbl.lex_backtrk[state];
        if (backtrk >= 0) {
            var pc_off = tbl.lex_backtrk_code[state];
            caml_lex_run_tag(tbl.lex_code, pc_off, lexbuf[lex_mem]);
            lexbuf[lex_last_pos] = lexbuf[lex_curr_pos];
            lexbuf[lex_last_action] = backtrk;
        }
        /* See if we need a refill */
        if (lexbuf[lex_curr_pos] >= lexbuf[lex_buffer_len]) {
            if (lexbuf[lex_eof_reached] == 0)
                return -state - 1;
            else
                c = 256;
        }
        else {
            /* Read next input char */
            c = buffer[lexbuf[lex_curr_pos]];
            lexbuf[lex_curr_pos]++;
        }
        /* Determine next state */
        var pstate = state;
        if (tbl.lex_check[base + c] == state)
            state = tbl.lex_trans[base + c];
        else
            state = tbl.lex_default[state];
        /* If no transition on this char, return to last backtrack point */
        if (state < 0) {
            lexbuf[lex_curr_pos] = lexbuf[lex_last_pos];
            if (lexbuf[lex_last_action] == -1)
                throw exn;
            else
                return lexbuf[lex_last_action];
        }
        else {
            /* If some transition, get and perform memory moves */
            var base_code = tbl.lex_base_code[pstate], pc_off;
            if (tbl.lex_check_code[base_code + c] == pstate)
                pc_off = tbl.lex_trans_code[base_code + c];
            else
                pc_off = tbl.lex_default_code[pstate];
            if (pc_off > 0)
                caml_lex_run_mem(tbl.lex_code, pc_off, lexbuf[lex_mem], lexbuf[lex_curr_pos]);
            /* Erase the EOF condition only if the EOF pseudo-character was
             consumed by the automaton (i.e. there was no backtrack above)
             */
            if (c == 256)
                lexbuf[lex_eof_reached] = 0;
        }
    }
    });

function caml_new_lex_engine(tbl, i, buf) do
  return caml_new_lex_engine_aux(tbl, i, buf, {
              Caml_builtin_exceptions.failure,
              empty_token_lit
            });
end end

exports.caml_lex_engine = caml_lex_engine;
exports.caml_new_lex_engine = caml_new_lex_engine;
--[[  Not a pure module ]]
