--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Js_exn = require "../../lib/js/js_exn.lua";
Pervasives = require "../../lib/js/pervasives.lua";
Caml_exceptions = require "../../lib/js/caml_exceptions.lua";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

Local = Caml_exceptions.create("Exception_raise_test.Local");

B = Caml_exceptions.create("Exception_raise_test.B");

C = Caml_exceptions.create("Exception_raise_test.C");

D = Caml_exceptions.create("Exception_raise_test.D");

function appf(g, x) do
  A = Caml_exceptions.create("A");
  try do
    return Curry._1(g, x);
  end
  catch (raw_exn)do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn == Local) then do
      return 3;
    end else if (exn == Caml_builtin_exceptions.not_found) then do
      return 2;
    end else if (exn[0] == A) then do
      return 3;
    end else if (exn[0] == B) then do
      match = exn[1];
      if (match) then do
        match$1 = match[1];
        if (match$1) then do
          match$2 = match$1[1];
          if (match$2) then do
            return match$2[0];
          end else do
            return 4;
          end end 
        end else do
          return 4;
        end end 
      end else do
        return 4;
      end end 
    end else if (exn[0] == C) then do
      return exn[1];
    end else if (exn[0] == D) then do
      return exn[1][0];
    end else do
      return 4;
    end end  end  end  end  end  end 
  end
end end

A = Caml_exceptions.create("Exception_raise_test.A");

f;

try do
  f = (function () {throw (new Error ("x"))} ());
end
catch (raw_exn)do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  f = exn[0] == A and exn[1] or 2;
end

ff;

try do
  ff = (function () {throw 3} ());
end
catch (raw_exn$1)do
  exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
  ff = exn$1[0] == A and exn$1[1] or 2;
end

fff;

try do
  fff = (function () {throw 2} ());
end
catch (raw_exn$2)do
  exn$2 = Caml_js_exceptions.internalToOCamlException(raw_exn$2);
  fff = exn$2[0] == A and exn$2[1] or 2;
end

a0;

try do
  a0 = (function (){throw 2} ());
end
catch (raw_exn$3)do
  exn$3 = Caml_js_exceptions.internalToOCamlException(raw_exn$3);
  if (exn$3[0] == A or exn$3[0] == Js_exn.__Error) then do
    a0 = exn$3[1];
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "exception_raise_test.ml",
            102,
            9
          ]
        ];
  end end 
end

a1;

try do
  a1 = (function (){throw 2} ());
end
catch (raw_e)do
  a1 = Caml_js_exceptions.internalToOCamlException(raw_e);
end

a2;

try do
  a2 = (function (){throw (new Error("x"))} ());
end
catch (raw_e$1)do
  a2 = Caml_js_exceptions.internalToOCamlException(raw_e$1);
end

suites = do
  contents: --[[ :: ]][
    --[[ tuple ]][
      "File \"exception_raise_test.ml\", line 114, characters 4-11",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    --[[ tuple ]][
                      f,
                      ff,
                      fff,
                      a0
                    ],
                    --[[ tuple ]][
                      2,
                      2,
                      2,
                      2
                    ]
                  ]);
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "File \"exception_raise_test.ml\", line 116, characters 4-11",
        (function (param) do
            if (a1[0] == Js_exn.__Error) then do
              return --[[ Eq ]]Block.__(0, [
                        a1[1],
                        2
                      ]);
            end else do
              throw [
                    Caml_builtin_exceptions.assert_failure,
                    --[[ tuple ]][
                      "exception_raise_test.ml",
                      119,
                      15
                    ]
                  ];
            end end 
          end end)
      ],
      --[[ [] ]]0
    ]
  ]
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

try do
  (function (_)dothrow 2end(--[[ () ]]0));
end
catch (raw_e$2)do
  e = Caml_js_exceptions.internalToOCamlException(raw_e$2);
  eq("File \"exception_raise_test.ml\", line 131, characters 7-14", Caml_js_exceptions.caml_as_js_exn(e) ~= undefined, true);
end

try do
  throw Caml_builtin_exceptions.not_found;
end
catch (raw_e$3)do
  e$1 = Caml_js_exceptions.internalToOCamlException(raw_e$3);
  eq("File \"exception_raise_test.ml\", line 138, characters 7-14", Caml_js_exceptions.caml_as_js_exn(e$1) ~= undefined, false);
end

function fff0(x, g) do
  val;
  try do
    val = Curry._1(x, --[[ () ]]0);
  end
  catch (exn)do
    return 1;
  end
  return Curry._1(g, --[[ () ]]0);
end end

function input_lines(ic, _acc) do
  while(true) do
    acc = _acc;
    line;
    try do
      line = Pervasives.input_line(ic);
    end
    catch (exn)do
      return List.rev(acc);
    end
    _acc = --[[ :: ]][
      line,
      acc
    ];
    continue ;
  end;
end end

eq("File \"exception_raise_test.ml\", line 150, characters 5-12", function (a,b,c,_)doreturn a + b + c end(1, 2, 3, 4), 6);

Mt.from_pair_suites("Exception_raise_test", suites.contents);

exports.Local = Local;
exports.B = B;
exports.C = C;
exports.D = D;
exports.appf = appf;
exports.A = A;
exports.f = f;
exports.ff = ff;
exports.fff = fff;
exports.a0 = a0;
exports.a1 = a1;
exports.a2 = a2;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.fff0 = fff0;
exports.input_lines = input_lines;
--[[ f Not a pure module ]]