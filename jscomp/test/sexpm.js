'use strict';

var Sys = require("../../lib/js/sys.js");
var Char = require("../../lib/js/char.js");
var List = require("../../lib/js/list.js");
var Block = require("../../lib/js/block.js");
var Bytes = require("../../lib/js/bytes.js");
var Curry = require("../../lib/js/curry.js");
var $$Buffer = require("../../lib/js/buffer.js");
var Format = require("../../lib/js/format.js");
var Printf = require("../../lib/js/printf.js");
var $$String = require("../../lib/js/string.js");
var Caml_io = require("../../lib/js/caml_io.js");
var Printexc = require("../../lib/js/printexc.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");
var Caml_int32 = require("../../lib/js/caml_int32.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_external_polyfill = require("../../lib/js/caml_external_polyfill.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function _with_in(filename, f) do
  var ic = Pervasives.open_in_bin(filename);
  try do
    var x = Curry._1(f, ic);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
    return x;
  end
  catch (raw_e)do
    var e = Caml_js_exceptions.internalToOCamlException(raw_e);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
    return --[ `Error ]--[
            106380200,
            Printexc.to_string(e)
          ];
  end
end

function _must_escape(s) do
  try do
    for(var i = 0 ,i_finish = #s - 1 | 0; i <= i_finish; ++i)do
      var c = s.charCodeAt(i);
      var exit = 0;
      if (c >= 42) do
        if (c ~= 59) do
          if (c ~= 92) do
            exit = 1;
          end else do
            throw Pervasives.Exit;
          end
        end else do
          throw Pervasives.Exit;
        end
      end else if (c >= 11) do
        if (c >= 32) do
          switch (c - 32 | 0) do
            case 1 :
            case 3 :
            case 4 :
            case 5 :
            case 6 :
            case 7 :
                exit = 1;
                break;
            case 0 :
            case 2 :
            case 8 :
            case 9 :
                throw Pervasives.Exit;
            
          end
        end else do
          exit = 1;
        end
      end else do
        if (c >= 9) do
          throw Pervasives.Exit;
        end
        exit = 1;
      end
      if (exit == 1 and c > 127) do
        throw Pervasives.Exit;
      end
      
    end
    return false;
  end
  catch (exn)do
    if (exn == Pervasives.Exit) do
      return true;
    end else do
      throw exn;
    end
  end
end

function to_buf(b, t) do
  if (t[0] >= 848054398) do
    var l = t[1];
    if (l) do
      if (l[1]) do
        $$Buffer.add_char(b, --[ "(" ]--40);
        List.iteri((function (i, t$prime) do
                if (i > 0) do
                  $$Buffer.add_char(b, --[ " " ]--32);
                end
                return to_buf(b, t$prime);
              end), l);
        return $$Buffer.add_char(b, --[ ")" ]--41);
      end else do
        return Curry._2(Printf.bprintf(b, --[ Format ]--[
                        --[ Char_literal ]--Block.__(12, [
                            --[ "(" ]--40,
                            --[ Alpha ]--Block.__(15, [--[ Char_literal ]--Block.__(12, [
                                    --[ ")" ]--41,
                                    --[ End_of_format ]--0
                                  ])])
                          ]),
                        "(%a)"
                      ]), to_buf, l[0]);
      end
    end else do
      return $$Buffer.add_string(b, "()");
    end
  end else do
    var s = t[1];
    if (_must_escape(s)) do
      return Curry._1(Printf.bprintf(b, --[ Format ]--[
                      --[ Char_literal ]--Block.__(12, [
                          --[ "\"" ]--34,
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ Char_literal ]--Block.__(12, [
                                  --[ "\"" ]--34,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ]),
                      "\"%s\""
                    ]), $$String.escaped(s));
    end else do
      return $$Buffer.add_string(b, s);
    end
  end
end

function to_string(t) do
  var b = $$Buffer.create(128);
  to_buf(b, t);
  return $$Buffer.contents(b);
end

function print(fmt, t) do
  if (t[0] >= 848054398) do
    var l = t[1];
    if (l) do
      if (l[1]) do
        Format.fprintf(fmt, --[ Format ]--[
              --[ Formatting_gen ]--Block.__(18, [
                  --[ Open_box ]--Block.__(1, [--[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "<hov1>",
                            --[ End_of_format ]--0
                          ]),
                        "<hov1>"
                      ]]),
                  --[ Char_literal ]--Block.__(12, [
                      --[ "(" ]--40,
                      --[ End_of_format ]--0
                    ])
                ]),
              "@[<hov1>("
            ]);
        List.iteri((function (i, t$prime) do
                if (i > 0) do
                  Format.fprintf(fmt, --[ Format ]--[
                        --[ Formatting_lit ]--Block.__(17, [
                            --[ Break ]--Block.__(0, [
                                "@ ",
                                1,
                                0
                              ]),
                            --[ End_of_format ]--0
                          ]),
                        "@ "
                      ]);
                end
                return print(fmt, t$prime);
              end), l);
        return Format.fprintf(fmt, --[ Format ]--[
                    --[ Char_literal ]--Block.__(12, [
                        --[ ")" ]--41,
                        --[ Formatting_lit ]--Block.__(17, [
                            --[ Close_box ]--0,
                            --[ End_of_format ]--0
                          ])
                      ]),
                    ")@]"
                  ]);
      end else do
        return Curry._2(Format.fprintf(fmt, --[ Format ]--[
                        --[ Formatting_gen ]--Block.__(18, [
                            --[ Open_box ]--Block.__(1, [--[ Format ]--[
                                  --[ String_literal ]--Block.__(11, [
                                      "<hov2>",
                                      --[ End_of_format ]--0
                                    ]),
                                  "<hov2>"
                                ]]),
                            --[ Char_literal ]--Block.__(12, [
                                --[ "(" ]--40,
                                --[ Alpha ]--Block.__(15, [--[ Char_literal ]--Block.__(12, [
                                        --[ ")" ]--41,
                                        --[ Formatting_lit ]--Block.__(17, [
                                            --[ Close_box ]--0,
                                            --[ End_of_format ]--0
                                          ])
                                      ])])
                              ])
                          ]),
                        "@[<hov2>(%a)@]"
                      ]), print, l[0]);
      end
    end else do
      return Format.pp_print_string(fmt, "()");
    end
  end else do
    var s = t[1];
    if (_must_escape(s)) do
      return Curry._1(Format.fprintf(fmt, --[ Format ]--[
                      --[ Char_literal ]--Block.__(12, [
                          --[ "\"" ]--34,
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ Char_literal ]--Block.__(12, [
                                  --[ "\"" ]--34,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ]),
                      "\"%s\""
                    ]), $$String.escaped(s));
    end else do
      return Format.pp_print_string(fmt, s);
    end
  end
end

function print_noindent(fmt, t) do
  if (t[0] >= 848054398) do
    var l = t[1];
    if (l) do
      if (l[1]) do
        Format.pp_print_char(fmt, --[ "(" ]--40);
        List.iteri((function (i, t$prime) do
                if (i > 0) do
                  Format.pp_print_char(fmt, --[ " " ]--32);
                end
                return print_noindent(fmt, t$prime);
              end), l);
        return Format.pp_print_char(fmt, --[ ")" ]--41);
      end else do
        return Curry._2(Format.fprintf(fmt, --[ Format ]--[
                        --[ Char_literal ]--Block.__(12, [
                            --[ "(" ]--40,
                            --[ Alpha ]--Block.__(15, [--[ Char_literal ]--Block.__(12, [
                                    --[ ")" ]--41,
                                    --[ End_of_format ]--0
                                  ])])
                          ]),
                        "(%a)"
                      ]), print_noindent, l[0]);
      end
    end else do
      return Format.pp_print_string(fmt, "()");
    end
  end else do
    var s = t[1];
    if (_must_escape(s)) do
      return Curry._1(Format.fprintf(fmt, --[ Format ]--[
                      --[ Char_literal ]--Block.__(12, [
                          --[ "\"" ]--34,
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ Char_literal ]--Block.__(12, [
                                  --[ "\"" ]--34,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ]),
                      "\"%s\""
                    ]), $$String.escaped(s));
    end else do
      return Format.pp_print_string(fmt, s);
    end
  end
end

function to_chan(oc, t) do
  var fmt = Format.formatter_of_out_channel(oc);
  print(fmt, t);
  return Format.pp_print_flush(fmt, --[ () ]--0);
end

function to_file_seq(filename, seq) do
  var filename$1 = filename;
  var f = function (oc) do
    return Curry._1(seq, (function (t) do
                  to_chan(oc, t);
                  return Caml_io.caml_ml_output_char(oc, --[ "\n" ]--10);
                end));
  end;
  var oc = Pervasives.open_out(filename$1);
  try do
    var x = Curry._1(f, oc);
    Caml_io.caml_ml_flush(oc);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
    return x;
  end
  catch (e)do
    Caml_io.caml_ml_flush(oc);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
    throw e;
  end
end

function to_file(filename, t) do
  return to_file_seq(filename, (function (k) do
                return Curry._1(k, t);
              end));
end

function $$return(x) do
  return x;
end

function $great$great$eq(x, f) do
  return Curry._1(f, x);
end

var ID_MONAD = do
  $$return: $$return,
  $great$great$eq: $great$great$eq
end;

function make(bufsizeOpt, refill) do
  var bufsize = bufsizeOpt ~= undefined ? bufsizeOpt : 1024;
  var bufsize$1 = Caml_primitive.caml_int_min(bufsize > 16 ? bufsize : 16, Sys.max_string_length);
  return do
          buf: Caml_bytes.caml_create_bytes(bufsize$1),
          refill: refill,
          atom: $$Buffer.create(32),
          i: 0,
          len: 0,
          line: 1,
          col: 1
        end;
end

function _is_digit(c) do
  if (--[ "0" ]--48 <= c) do
    return c <= --[ "9" ]--57;
  end else do
    return false;
  end
end

function _refill(t, k_succ, k_fail) do
  var n = Curry._3(t.refill, t.buf, 0, #t.buf);
  t.i = 0;
  t.len = n;
  if (n == 0) do
    return Curry._1(k_fail, t);
  end else do
    return Curry._1(k_succ, t);
  end
end

function _get(t) do
  if (t.i >= t.len) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "sexpm.ml",
            152,
            4
          ]
        ];
  end
  var c = Caml_bytes.get(t.buf, t.i);
  t.i = t.i + 1 | 0;
  if (c == --[ "\n" ]--10) do
    t.col = 1;
    t.line = t.line + 1 | 0;
  end else do
    t.col = t.col + 1 | 0;
  end
  return c;
end

function _error(t, msg) do
  var b = $$Buffer.create(32);
  Curry._2(Printf.bprintf(b, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "at ",
                --[ Int ]--Block.__(4, [
                    --[ Int_d ]--0,
                    --[ No_padding ]--0,
                    --[ No_precision ]--0,
                    --[ String_literal ]--Block.__(11, [
                        ", ",
                        --[ Int ]--Block.__(4, [
                            --[ Int_d ]--0,
                            --[ No_padding ]--0,
                            --[ No_precision ]--0,
                            --[ String_literal ]--Block.__(11, [
                                ": ",
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ])
              ]),
            "at %d, %d: "
          ]), t.line, t.col);
  return Printf.kbprintf((function (b) do
                var msg$prime = $$Buffer.contents(b);
                return --[ `Error ]--[
                        106380200,
                        msg$prime
                      ];
              end), b, msg);
end

function _error_eof(t) do
  return _error(t, --[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  "unexpected end of input",
                  --[ End_of_format ]--0
                ]),
              "unexpected end of input"
            ]);
end

function expr(k, t) do
  while(true) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return expr(k, param);
                  end), _error_eof);
    end else do
      var c = _get(t);
      if (c >= 11) do
        if (c ~= 32) do
          return expr_starting_with(c, k, t);
        end else do
          continue ;
        end
      end else if (c >= 9) do
        continue ;
      end else do
        return expr_starting_with(c, k, t);
      end
    end
  end;
end

function expr_starting_with(c, k, t) do
  if (c >= 42) do
    if (c ~= 59) do
      if (c == 92) do
        return _error(t, --[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "unexpected '\\'",
                        --[ End_of_format ]--0
                      ]),
                    "unexpected '\\'"
                  ]);
      end
      
    end else do
      return skip_comment((function (param, param$1) do
                    return expr(k, t);
                  end), t);
    end
  end else if (c >= 11) do
    if (c >= 32) do
      switch (c - 32 | 0) do
        case 0 :
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "sexpm.ml",
                    183,
                    27
                  ]
                ];
        case 2 :
            return quoted(k, t);
        case 1 :
        case 3 :
        case 4 :
        case 5 :
        case 6 :
        case 7 :
            break;
        case 8 :
            return expr_list(--[ [] ]--0, k, t);
        case 9 :
            return _error(t, --[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "unexpected ')'",
                            --[ End_of_format ]--0
                          ]),
                        "unexpected ')'"
                      ]);
        
      end
    end
    
  end else if (c >= 9) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "sexpm.ml",
            183,
            27
          ]
        ];
  end
  $$Buffer.add_char(t.atom, c);
  return atom(k, t);
end

function expr_list(acc, k, t) do
  while(true) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return expr_list(acc, k, param);
                  end), _error_eof);
    end else do
      var c = _get(t);
      var switcher = c - 9 | 0;
      if (switcher > 23 or switcher < 0) do
        if (switcher == 32) do
          return Curry._2(k, undefined, --[ `List ]--[
                      848054398,
                      List.rev(acc)
                    ]);
        end
        
      end else if (switcher > 22 or switcher < 2) do
        continue ;
      end
      return expr_starting_with(c, (function (last, e) do
                    if (last ~= undefined) do
                      var match = last;
                      if (match ~= 40) do
                        if (match ~= 41) do
                          return expr_list(--[ :: ]--[
                                      e,
                                      acc
                                    ], k, t);
                        end else do
                          return Curry._2(k, undefined, --[ `List ]--[
                                      848054398,
                                      List.rev(--[ :: ]--[
                                            e,
                                            acc
                                          ])
                                    ]);
                        end
                      end else do
                        return expr_list(--[ [] ]--0, (function (param, l) do
                                      return expr_list(--[ :: ]--[
                                                  l,
                                                  acc
                                                ], k, t);
                                    end), t);
                      end
                    end else do
                      return expr_list(--[ :: ]--[
                                  e,
                                  acc
                                ], k, t);
                    end
                  end), t);
    end
  end;
end

function _return_atom(last, k, t) do
  var s = $$Buffer.contents(t.atom);
  t.atom.position = 0;
  return Curry._2(k, last, --[ `Atom ]--[
              726615281,
              s
            ]);
end

function atom(k, t) do
  while(true) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return atom(k, param);
                  end), (function (param) do
                    return _return_atom(undefined, k, param);
                  end));
    end else do
      var c = _get(t);
      var exit = 0;
      if (c >= 35) do
        if (c >= 42) do
          if (c ~= 92) do
            exit = 1;
          end else do
            return _error(t, --[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "unexpected '\\' in non-quoted string",
                            --[ End_of_format ]--0
                          ]),
                        "unexpected '\\' in non-quoted string"
                      ]);
          end
        end else do
          exit = c >= 40 ? 2 : 1;
        end
      end else if (c >= 11) do
        if (c >= 32) do
          switch (c - 32 | 0) do
            case 0 :
                exit = 2;
                break;
            case 1 :
                exit = 1;
                break;
            case 2 :
                return _error(t, --[ Format ]--[
                            --[ String_literal ]--Block.__(11, [
                                "unexpected '\"' in the middle of an atom",
                                --[ End_of_format ]--0
                              ]),
                            "unexpected '\"' in the middle of an atom"
                          ]);
            
          end
        end else do
          exit = 1;
        end
      end else do
        exit = c >= 9 ? 2 : 1;
      end
      switch (exit) do
        case 1 :
            $$Buffer.add_char(t.atom, c);
            continue ;
        case 2 :
            return _return_atom(c, k, t);
        
      end
    end
  end;
end

function quoted(k, t) do
  while(true) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return quoted(k, param);
                  end), _error_eof);
    end else do
      var c = _get(t);
      if (c ~= 34) do
        if (c ~= 92) do
          $$Buffer.add_char(t.atom, c);
          continue ;
        end else do
          return escaped((function (c) do
                        $$Buffer.add_char(t.atom, c);
                        return quoted(k, t);
                      end), t);
        end
      end else do
        return _return_atom(undefined, k, t);
      end
    end
  end;
end

function escaped(k, t) do
  if (t.i == t.len) do
    return _refill(t, (function (param) do
                  return escaped(k, param);
                end), _error_eof);
  end else do
    var c = _get(t);
    if (c >= 92) do
      if (c < 117) do
        switch (c - 92 | 0) do
          case 0 :
              return Curry._1(k, --[ "\\" ]--92);
          case 6 :
              return Curry._1(k, --[ "\b" ]--8);
          case 18 :
              return Curry._1(k, --[ "\n" ]--10);
          case 22 :
              return Curry._1(k, --[ "\r" ]--13);
          case 1 :
          case 2 :
          case 3 :
          case 4 :
          case 5 :
          case 7 :
          case 8 :
          case 9 :
          case 10 :
          case 11 :
          case 12 :
          case 13 :
          case 14 :
          case 15 :
          case 16 :
          case 17 :
          case 19 :
          case 20 :
          case 21 :
          case 23 :
              break;
          case 24 :
              return Curry._1(k, --[ "\t" ]--9);
          
        end
      end
      
    end else if (c == 34) do
      return Curry._1(k, --[ "\"" ]--34);
    end
    if (_is_digit(c)) do
      return read2int(c - --[ "0" ]--48 | 0, (function (n) do
                    return Curry._1(k, Char.chr(n));
                  end), t);
    end else do
      return Curry._1(_error(t, --[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "unexpected escaped char '",
                          --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                                  --[ "'" ]--39,
                                  --[ End_of_format ]--0
                                ])])
                        ]),
                      "unexpected escaped char '%c'"
                    ]), c);
    end
  end
end

function read2int(i, k, t) do
  if (t.i == t.len) do
    return _refill(t, (function (param) do
                  return read2int(i, k, param);
                end), _error_eof);
  end else do
    var c = _get(t);
    if (_is_digit(c)) do
      return read1int(Caml_int32.imul(10, i) + (c - --[ "0" ]--48 | 0) | 0, k, t);
    end else do
      return Curry._1(_error(t, --[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "unexpected char '",
                          --[ Char ]--Block.__(0, [--[ String_literal ]--Block.__(11, [
                                  "' when reading byte",
                                  --[ End_of_format ]--0
                                ])])
                        ]),
                      "unexpected char '%c' when reading byte"
                    ]), c);
    end
  end
end

function read1int(i, k, t) do
  if (t.i == t.len) do
    return _refill(t, (function (param) do
                  return read1int(i, k, param);
                end), _error_eof);
  end else do
    var c = _get(t);
    if (_is_digit(c)) do
      return Curry._1(k, Caml_int32.imul(10, i) + (c - --[ "0" ]--48 | 0) | 0);
    end else do
      return Curry._1(_error(t, --[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "unexpected char '",
                          --[ Char ]--Block.__(0, [--[ String_literal ]--Block.__(11, [
                                  "' when reading byte",
                                  --[ End_of_format ]--0
                                ])])
                        ]),
                      "unexpected char '%c' when reading byte"
                    ]), c);
    end
  end
end

function skip_comment(k, t) do
  while(true) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return skip_comment(k, param);
                  end), _error_eof);
    end else do
      var match = _get(t);
      if (match ~= 10) do
        continue ;
      end else do
        return Curry._2(k, undefined, --[ () ]--0);
      end
    end
  end;
end

function expr_or_end(k, t) do
  while(true) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return expr_or_end(k, param);
                  end), (function (param) do
                    return --[ End ]--3455931;
                  end));
    end else do
      var c = _get(t);
      if (c >= 11) do
        if (c ~= 32) do
          return expr_starting_with(c, k, t);
        end else do
          continue ;
        end
      end else if (c >= 9) do
        continue ;
      end else do
        return expr_starting_with(c, k, t);
      end
    end
  end;
end

function next(t) do
  return expr_or_end((function (param, x) do
                return --[ `Ok ]--[
                        17724,
                        x
                      ];
              end), t);
end

function parse_string(s) do
  var n = #s;
  var stop = do
    contents: false
  end;
  var refill = function (bytes, i, _len) do
    if (stop.contents) do
      return 0;
    end else do
      stop.contents = true;
      Bytes.blit_string(s, 0, bytes, i, n);
      return n;
    end
  end;
  var d = make(n, refill);
  var res = next(d);
  if (typeof res == "number") do
    return --[ `Error ]--[
            106380200,
            "unexpected end of file"
          ];
  end else do
    return res;
  end
end

function parse_chan(bufsize, ic) do
  var d = make(bufsize, (function (param, param$1, param$2) do
          return Pervasives.input(ic, param, param$1, param$2);
        end));
  var res = next(d);
  if (typeof res == "number") do
    return --[ `Error ]--[
            106380200,
            "unexpected end of file"
          ];
  end else do
    return res;
  end
end

function parse_chan_gen(bufsize, ic) do
  var d = make(bufsize, (function (param, param$1, param$2) do
          return Pervasives.input(ic, param, param$1, param$2);
        end));
  return (function (param) do
      var e = next(d);
      if (typeof e == "number") do
        return ;
      end else do
        return e;
      end
    end);
end

function parse_chan_list(bufsize, ic) do
  var d = make(bufsize, (function (param, param$1, param$2) do
          return Pervasives.input(ic, param, param$1, param$2);
        end));
  var _acc = --[ [] ]--0;
  while(true) do
    var acc = _acc;
    var e = next(d);
    if (typeof e == "number") do
      return --[ `Ok ]--[
              17724,
              List.rev(acc)
            ];
    end else if (e[0] >= 106380200) do
      return e;
    end else do
      _acc = --[ :: ]--[
        e[1],
        acc
      ];
      continue ;
    end
  end;
end

function parse_file(filename) do
  return _with_in(filename, (function (ic) do
                return parse_chan(undefined, ic);
              end));
end

function parse_file_list(filename) do
  return _with_in(filename, (function (ic) do
                return parse_chan_list(undefined, ic);
              end));
end

function MakeDecode(funarg) do
  var $great$great$eq = funarg.$great$great$eq;
  var make = function (bufsizeOpt, refill) do
    var bufsize = bufsizeOpt ~= undefined ? bufsizeOpt : 1024;
    var bufsize$1 = Caml_primitive.caml_int_min(bufsize > 16 ? bufsize : 16, Sys.max_string_length);
    return do
            buf: Caml_bytes.caml_create_bytes(bufsize$1),
            refill: refill,
            atom: $$Buffer.create(32),
            i: 0,
            len: 0,
            line: 1,
            col: 1
          end;
  end;
  var _is_digit = function (c) do
    if (--[ "0" ]--48 <= c) do
      return c <= --[ "9" ]--57;
    end else do
      return false;
    end
  end;
  var _refill = function (t, k_succ, k_fail) do
    return Curry._2($great$great$eq, Curry._3(t.refill, t.buf, 0, #t.buf), (function (n) do
                  t.i = 0;
                  t.len = n;
                  if (n == 0) do
                    return Curry._1(k_fail, t);
                  end else do
                    return Curry._1(k_succ, t);
                  end
                end));
  end;
  var _get = function (t) do
    if (t.i >= t.len) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "sexpm.ml",
              152,
              4
            ]
          ];
    end
    var c = Caml_bytes.get(t.buf, t.i);
    t.i = t.i + 1 | 0;
    if (c == --[ "\n" ]--10) do
      t.col = 1;
      t.line = t.line + 1 | 0;
    end else do
      t.col = t.col + 1 | 0;
    end
    return c;
  end;
  var _error = function (t, msg) do
    var b = $$Buffer.create(32);
    Curry._2(Printf.bprintf(b, --[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  "at ",
                  --[ Int ]--Block.__(4, [
                      --[ Int_d ]--0,
                      --[ No_padding ]--0,
                      --[ No_precision ]--0,
                      --[ String_literal ]--Block.__(11, [
                          ", ",
                          --[ Int ]--Block.__(4, [
                              --[ Int_d ]--0,
                              --[ No_padding ]--0,
                              --[ No_precision ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  ": ",
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ])
                ]),
              "at %d, %d: "
            ]), t.line, t.col);
    return Printf.kbprintf((function (b) do
                  var msg$prime = $$Buffer.contents(b);
                  return Curry._1(funarg.$$return, --[ `Error ]--[
                              106380200,
                              msg$prime
                            ]);
                end), b, msg);
  end;
  var _error_eof = function (t) do
    return _error(t, --[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "unexpected end of input",
                    --[ End_of_format ]--0
                  ]),
                "unexpected end of input"
              ]);
  end;
  var expr = function (k, t) do
    while(true) do
      if (t.i == t.len) do
        return _refill(t, (function (param) do
                      return expr(k, param);
                    end), _error_eof);
      end else do
        var c = _get(t);
        if (c >= 11) do
          if (c ~= 32) do
            return expr_starting_with(c, k, t);
          end else do
            continue ;
          end
        end else if (c >= 9) do
          continue ;
        end else do
          return expr_starting_with(c, k, t);
        end
      end
    end;
  end;
  var expr_starting_with = function (c, k, t) do
    if (c >= 42) do
      if (c ~= 59) do
        if (c == 92) do
          return _error(t, --[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "unexpected '\\'",
                          --[ End_of_format ]--0
                        ]),
                      "unexpected '\\'"
                    ]);
        end
        
      end else do
        return skip_comment((function (param, param$1) do
                      return expr(k, t);
                    end), t);
      end
    end else if (c >= 11) do
      if (c >= 32) do
        switch (c - 32 | 0) do
          case 0 :
              throw [
                    Caml_builtin_exceptions.assert_failure,
                    --[ tuple ]--[
                      "sexpm.ml",
                      183,
                      27
                    ]
                  ];
          case 2 :
              return quoted(k, t);
          case 1 :
          case 3 :
          case 4 :
          case 5 :
          case 6 :
          case 7 :
              break;
          case 8 :
              return expr_list(--[ [] ]--0, k, t);
          case 9 :
              return _error(t, --[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "unexpected ')'",
                              --[ End_of_format ]--0
                            ]),
                          "unexpected ')'"
                        ]);
          
        end
      end
      
    end else if (c >= 9) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "sexpm.ml",
              183,
              27
            ]
          ];
    end
    $$Buffer.add_char(t.atom, c);
    return atom(k, t);
  end;
  var expr_list = function (acc, k, t) do
    while(true) do
      if (t.i == t.len) do
        return _refill(t, (function (param) do
                      return expr_list(acc, k, param);
                    end), _error_eof);
      end else do
        var c = _get(t);
        var switcher = c - 9 | 0;
        if (switcher > 23 or switcher < 0) do
          if (switcher == 32) do
            return Curry._2(k, undefined, --[ `List ]--[
                        848054398,
                        List.rev(acc)
                      ]);
          end
          
        end else if (switcher > 22 or switcher < 2) do
          continue ;
        end
        return expr_starting_with(c, (function (last, e) do
                      if (last ~= undefined) do
                        var match = last;
                        if (match ~= 40) do
                          if (match ~= 41) do
                            return expr_list(--[ :: ]--[
                                        e,
                                        acc
                                      ], k, t);
                          end else do
                            return Curry._2(k, undefined, --[ `List ]--[
                                        848054398,
                                        List.rev(--[ :: ]--[
                                              e,
                                              acc
                                            ])
                                      ]);
                          end
                        end else do
                          return expr_list(--[ [] ]--0, (function (param, l) do
                                        return expr_list(--[ :: ]--[
                                                    l,
                                                    acc
                                                  ], k, t);
                                      end), t);
                        end
                      end else do
                        return expr_list(--[ :: ]--[
                                    e,
                                    acc
                                  ], k, t);
                      end
                    end), t);
      end
    end;
  end;
  var _return_atom = function (last, k, t) do
    var s = $$Buffer.contents(t.atom);
    t.atom.position = 0;
    return Curry._2(k, last, --[ `Atom ]--[
                726615281,
                s
              ]);
  end;
  var atom = function (k, t) do
    while(true) do
      if (t.i == t.len) do
        return _refill(t, (function (param) do
                      return atom(k, param);
                    end), (function (param) do
                      return _return_atom(undefined, k, param);
                    end));
      end else do
        var c = _get(t);
        var exit = 0;
        if (c >= 35) do
          if (c >= 42) do
            if (c ~= 92) do
              exit = 1;
            end else do
              return _error(t, --[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "unexpected '\\' in non-quoted string",
                              --[ End_of_format ]--0
                            ]),
                          "unexpected '\\' in non-quoted string"
                        ]);
            end
          end else do
            exit = c >= 40 ? 2 : 1;
          end
        end else if (c >= 11) do
          if (c >= 32) do
            switch (c - 32 | 0) do
              case 0 :
                  exit = 2;
                  break;
              case 1 :
                  exit = 1;
                  break;
              case 2 :
                  return _error(t, --[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "unexpected '\"' in the middle of an atom",
                                  --[ End_of_format ]--0
                                ]),
                              "unexpected '\"' in the middle of an atom"
                            ]);
              
            end
          end else do
            exit = 1;
          end
        end else do
          exit = c >= 9 ? 2 : 1;
        end
        switch (exit) do
          case 1 :
              $$Buffer.add_char(t.atom, c);
              continue ;
          case 2 :
              return _return_atom(c, k, t);
          
        end
      end
    end;
  end;
  var quoted = function (k, t) do
    while(true) do
      if (t.i == t.len) do
        return _refill(t, (function (param) do
                      return quoted(k, param);
                    end), _error_eof);
      end else do
        var c = _get(t);
        if (c ~= 34) do
          if (c ~= 92) do
            $$Buffer.add_char(t.atom, c);
            continue ;
          end else do
            return escaped((function (c) do
                          $$Buffer.add_char(t.atom, c);
                          return quoted(k, t);
                        end), t);
          end
        end else do
          return _return_atom(undefined, k, t);
        end
      end
    end;
  end;
  var escaped = function (k, t) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return escaped(k, param);
                  end), _error_eof);
    end else do
      var c = _get(t);
      if (c >= 92) do
        if (c < 117) do
          switch (c - 92 | 0) do
            case 0 :
                return Curry._1(k, --[ "\\" ]--92);
            case 6 :
                return Curry._1(k, --[ "\b" ]--8);
            case 18 :
                return Curry._1(k, --[ "\n" ]--10);
            case 22 :
                return Curry._1(k, --[ "\r" ]--13);
            case 1 :
            case 2 :
            case 3 :
            case 4 :
            case 5 :
            case 7 :
            case 8 :
            case 9 :
            case 10 :
            case 11 :
            case 12 :
            case 13 :
            case 14 :
            case 15 :
            case 16 :
            case 17 :
            case 19 :
            case 20 :
            case 21 :
            case 23 :
                break;
            case 24 :
                return Curry._1(k, --[ "\t" ]--9);
            
          end
        end
        
      end else if (c == 34) do
        return Curry._1(k, --[ "\"" ]--34);
      end
      if (_is_digit(c)) do
        return read2int(c - --[ "0" ]--48 | 0, (function (n) do
                      return Curry._1(k, Char.chr(n));
                    end), t);
      end else do
        return Curry._1(_error(t, --[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "unexpected escaped char '",
                            --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                                    --[ "'" ]--39,
                                    --[ End_of_format ]--0
                                  ])])
                          ]),
                        "unexpected escaped char '%c'"
                      ]), c);
      end
    end
  end;
  var read2int = function (i, k, t) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return read2int(i, k, param);
                  end), _error_eof);
    end else do
      var c = _get(t);
      if (_is_digit(c)) do
        return read1int(Caml_int32.imul(10, i) + (c - --[ "0" ]--48 | 0) | 0, k, t);
      end else do
        return Curry._1(_error(t, --[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "unexpected char '",
                            --[ Char ]--Block.__(0, [--[ String_literal ]--Block.__(11, [
                                    "' when reading byte",
                                    --[ End_of_format ]--0
                                  ])])
                          ]),
                        "unexpected char '%c' when reading byte"
                      ]), c);
      end
    end
  end;
  var read1int = function (i, k, t) do
    if (t.i == t.len) do
      return _refill(t, (function (param) do
                    return read1int(i, k, param);
                  end), _error_eof);
    end else do
      var c = _get(t);
      if (_is_digit(c)) do
        return Curry._1(k, Caml_int32.imul(10, i) + (c - --[ "0" ]--48 | 0) | 0);
      end else do
        return Curry._1(_error(t, --[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "unexpected char '",
                            --[ Char ]--Block.__(0, [--[ String_literal ]--Block.__(11, [
                                    "' when reading byte",
                                    --[ End_of_format ]--0
                                  ])])
                          ]),
                        "unexpected char '%c' when reading byte"
                      ]), c);
      end
    end
  end;
  var skip_comment = function (k, t) do
    while(true) do
      if (t.i == t.len) do
        return _refill(t, (function (param) do
                      return skip_comment(k, param);
                    end), _error_eof);
      end else do
        var match = _get(t);
        if (match ~= 10) do
          continue ;
        end else do
          return Curry._2(k, undefined, --[ () ]--0);
        end
      end
    end;
  end;
  var expr_or_end = function (k, t) do
    while(true) do
      if (t.i == t.len) do
        return _refill(t, (function (param) do
                      return expr_or_end(k, param);
                    end), (function (param) do
                      return Curry._1(funarg.$$return, --[ End ]--3455931);
                    end));
      end else do
        var c = _get(t);
        if (c >= 11) do
          if (c ~= 32) do
            return expr_starting_with(c, k, t);
          end else do
            continue ;
          end
        end else if (c >= 9) do
          continue ;
        end else do
          return expr_starting_with(c, k, t);
        end
      end
    end;
  end;
  var next = function (t) do
    return expr_or_end((function (param, x) do
                  return Curry._1(funarg.$$return, --[ `Ok ]--[
                              17724,
                              x
                            ]);
                end), t);
  end;
  return do
          make: make,
          next: next
        end;
end

var D = do
  make: make,
  next: next
end;

exports.to_buf = to_buf;
exports.to_string = to_string;
exports.to_file = to_file;
exports.to_file_seq = to_file_seq;
exports.to_chan = to_chan;
exports.print = print;
exports.print_noindent = print_noindent;
exports.MakeDecode = MakeDecode;
exports.ID_MONAD = ID_MONAD;
exports.D = D;
exports.parse_string = parse_string;
exports.parse_chan = parse_chan;
exports.parse_chan_gen = parse_chan_gen;
exports.parse_chan_list = parse_chan_list;
exports.parse_file = parse_file;
exports.parse_file_list = parse_file_list;
--[ Format Not a pure module ]--
