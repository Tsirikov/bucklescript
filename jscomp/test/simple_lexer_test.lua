'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");
Bytes = require("../../lib/js/bytes.lua");
Curry = require("../../lib/js/curry.lua");
Lexing = require("../../lib/js/lexing.lua");
Caml_bytes = require("../../lib/js/caml_bytes.lua");

__ocaml_lex_tables = do
  lex_base: "\0\0\xfd\xff\xfe\xff\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\x04\0\x01\0\x04\0\x03\0\0\0\x06\0\0\0\xff\xff",
  lex_backtrk: "\xff\xff\xff\xff\xff\xff\x01\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
  lex_default: "\x02\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0",
  lex_trans: "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\x03\0\x0b\0\x07\0\x0e\0\x0f\0\0\0\f\0\0\0\0\0\0\0\0\0\b\0\x11\0\0\0\0\0\x05\0\x06\0\t\0\x04\0\r\0\x10\0\x12\0\x13\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0",
  lex_check: "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\t\0\xff\xff\xff\xff\xff\xff\0\0\n\0\x06\0\r\0\x0e\0\xff\xff\x0b\0\xff\xff\xff\xff\xff\xff\xff\xff\x07\0\x10\0\xff\xff\xff\xff\x04\0\x05\0\b\0\x03\0\f\0\x0f\0\x11\0\x12\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
  lex_base_code: "",
  lex_backtrk_code: "",
  lex_default_code: "",
  lex_trans_code: "",
  lex_check_code: "",
  lex_code: ""
end;

function __ocaml_lex_translate_rec(lexbuf, ___ocaml_lex_state) do
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state$1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    local ___conditional___=(__ocaml_lex_state$1);
    do
       if ___conditional___ = 0 then do
          return "." .. __ocaml_lex_translate_rec(lexbuf, 0);end end end 
       if ___conditional___ = 1 then do
          c = Caml_bytes.get(lexbuf.lex_buffer, lexbuf.lex_start_pos);
          return Caml_bytes.bytes_to_string(Bytes.make(1, c)) .. __ocaml_lex_translate_rec(lexbuf, 0);end end end 
       if ___conditional___ = 2 then do
          return "";end end end 
       do
      else do
        Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state$1;
        continue ;
        end end
        
    end
  end;
end end

function translate(lexbuf) do
  return __ocaml_lex_translate_rec(lexbuf, 0);
end end

suites_000 = --[[ tuple ]][
  "translate",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                __ocaml_lex_translate_rec(Lexing.from_string("-- current_directory --"), 0),
                "-- . --"
              ]);
    end end)
];

suites = --[[ :: ]][
  suites_000,
  --[[ [] ]]0
];

Mt.from_pair_suites("Simple_lexer_test", suites);

exports.__ocaml_lex_tables = __ocaml_lex_tables;
exports.translate = translate;
exports.__ocaml_lex_translate_rec = __ocaml_lex_translate_rec;
exports.suites = suites;
--[[  Not a pure module ]]
