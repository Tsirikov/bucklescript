'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Js_mapperRt = require("../../lib/js/js_mapperRt.js");

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

function tToJs(param) do
  return do
          x: param.x,
          y: param.y,
          z: param.z
        end;
end

function tFromJs(param) do
  return do
          x: param.x,
          y: param.y,
          z: param.z
        end;
end

var v0 = do
  x: 3,
  y: false,
  z: false
end;

var v1 = do
  x: 3,
  y: false,
  z: ""
end;

var jsMapperConstantArray = [
  --[ tuple ]--[
    97,
    "a"
  ],
  --[ tuple ]--[
    98,
    "b"
  ],
  --[ tuple ]--[
    99,
    "c"
  ]
];

function xToJs(param) do
  return Js_mapperRt.binarySearch(3, param, jsMapperConstantArray);
end

function xFromJs(param) do
  return Js_mapperRt.revSearchAssert(3, jsMapperConstantArray, param);
end

function idx(v) do
  return eq("File \"ast_abstract_test.ml\", line 32, characters 17-24", xFromJs(xToJs(v)), v);
end

var x0 = xToJs(--[ a ]--97);

var x1 = xToJs(--[ b ]--98);

idx(--[ a ]--97);

idx(--[ b ]--98);

idx(--[ c ]--99);

var jsMapperConstantArray$1 = [
  0,
  3,
  4
];

function aToJs(param) do
  return jsMapperConstantArray$1[param];
end

function aFromJs(param) do
  return Js_mapperRt.fromIntAssert(3, jsMapperConstantArray$1, param);
end

function id(x) do
  return eq("File \"ast_abstract_test.ml\", line 49, characters 8-15", aFromJs(aToJs(x)), x);
end

var a0 = aToJs(--[ A ]--0);

var a1 = aToJs(--[ B ]--1);

id(--[ A ]--0);

id(--[ B ]--1);

id(--[ C ]--2);

function bToJs(param) do
  return param + 0 | 0;
end

function bFromJs(param) do
  if (!(param <= 3 and 0 <= param)) do
    throw new Error("ASSERT FAILURE");
  end
  return param - 0 | 0;
end

var b0 = 0;

var b1 = 1;

function idb(v) do
  return eq("File \"ast_abstract_test.ml\", line 71, characters 5-12", bFromJs(v + 0 | 0), v);
end

idb(--[ D0 ]--0);

idb(--[ D1 ]--1);

idb(--[ D2 ]--2);

idb(--[ D3 ]--3);

function cToJs(param) do
  return param + 3 | 0;
end

function cFromJs(param) do
  if (!(param <= 6 and 3 <= param)) do
    throw new Error("ASSERT FAILURE");
  end
  return param - 3 | 0;
end

var c0 = 3;

function idc(v) do
  return eq("File \"ast_abstract_test.ml\", line 83, characters 15-22", cFromJs(v + 3 | 0), v);
end

idc(--[ D0 ]--0);

idc(--[ D1 ]--1);

idc(--[ D2 ]--2);

idc(--[ D3 ]--3);

function hToJs(param) do
  return param + 0 | 0;
end

function hFromJs(param) do
  if (!(param <= 1 and 0 <= param)) do
    throw new Error("ASSERT FAILURE");
  end
  return param - 0 | 0;
end

function zToJs(param) do
  return param + 0 | 0;
end

function zFromJs(param) do
  if (param <= 2 and 0 <= param) do
    return param - 0 | 0;
  end
  
end

Mt.from_pair_suites("Ast_abstract_test", suites.contents);

var jsMapperEraseType = --[ JsMapperEraseType ]--0;

var b = --[ B ]--1;

var zXx = --[ ZXx ]--2;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.tToJs = tToJs;
exports.tFromJs = tFromJs;
exports.v0 = v0;
exports.v1 = v1;
exports.xToJs = xToJs;
exports.xFromJs = xFromJs;
exports.idx = idx;
exports.x0 = x0;
exports.x1 = x1;
exports.aToJs = aToJs;
exports.aFromJs = aFromJs;
exports.id = id;
exports.a0 = a0;
exports.a1 = a1;
exports.bToJs = bToJs;
exports.bFromJs = bFromJs;
exports.b0 = b0;
exports.b1 = b1;
exports.idb = idb;
exports.cToJs = cToJs;
exports.cFromJs = cFromJs;
exports.c0 = c0;
exports.idc = idc;
exports.jsMapperEraseType = jsMapperEraseType;
exports.b = b;
exports.hToJs = hToJs;
exports.hFromJs = hFromJs;
exports.zXx = zXx;
exports.zToJs = zToJs;
exports.zFromJs = zFromJs;
--[ x0 Not a pure module ]--
