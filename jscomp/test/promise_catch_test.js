'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Js_exn = require("../../lib/js/js_exn.js");
var Js_option = require("../../lib/js/js_option.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function handler(e) do
  if (e[0] == Js_exn.$$Error) do
    console.log("js error");
    return Promise.resolve(0);
  end else if (e == Caml_builtin_exceptions.not_found) do
    console.log("hi");
    return Promise.resolve(0);
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "promise_catch_test.ml",
            22,
            9
          ]
        ];
  end
end

function myHandler(match) do
  if (Caml_exceptions.caml_is_extension(match)) do
    if (match == Caml_builtin_exceptions.not_found) do
      return 1;
    end else if (match[0] == Js_exn.$$Error) do
      return 2;
    end else do
      return ;
    end
  end
  
end

function f(x) do
  return x.catch(handler);
end

var exit = 0;

var val;

try do
  val = JSON.parse(" 1. +  ");
  exit = 1;
end
catch (raw_e)do
  var e = Caml_js_exceptions.internalToOCamlException(raw_e);
  eq("File \"promise_catch_test.ml\", line 36, characters 7-14", true, Js_option.isSomeValue((function (xxx, y) do
              return xxx == y;
            end), 2, myHandler(e)));
end

if (exit == 1) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "promise_catch_test.ml",
          39,
          9
        ]
      ];
end

Mt.from_pair_suites("Promise_catch_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.handler = handler;
exports.myHandler = myHandler;
exports.f = f;
--[  Not a pure module ]--
