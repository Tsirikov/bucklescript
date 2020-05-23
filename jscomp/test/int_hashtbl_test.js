'use strict';

var Mt = require("./mt.js");
var List = require("../../lib/js/list.js");
var $$Array = require("../../lib/js/array.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Hashtbl = require("../../lib/js/hashtbl.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");

function f(H) do
  var tbl = Curry._1(H.create, 17);
  Curry._3(H.add, tbl, 1, --[ "1" ]--49);
  Curry._3(H.add, tbl, 2, --[ "2" ]--50);
  return List.sort((function (param, param$1) do
                return Caml_primitive.caml_int_compare(param[0], param$1[0]);
              end), Curry._3(H.fold, (function (k, v, acc) do
                    return --[ :: ]--[
                            --[ tuple ]--[
                              k,
                              v
                            ],
                            acc
                          ];
                  end), tbl, --[ [] ]--0));
end

function g(H, count) do
  var tbl = Curry._1(H.create, 17);
  for(var i = 0; i <= count; ++i)do
    Curry._3(H.replace, tbl, (i << 1), String(i));
  end
  for(var i$1 = 0; i$1 <= count; ++i$1)do
    Curry._3(H.replace, tbl, (i$1 << 1), String(i$1));
  end
  var v = Curry._3(H.fold, (function (k, v, acc) do
          return --[ :: ]--[
                  --[ tuple ]--[
                    k,
                    v
                  ],
                  acc
                ];
        end), tbl, --[ [] ]--0);
  return $$Array.of_list(List.sort((function (param, param$1) do
                    return Caml_primitive.caml_int_compare(param[0], param$1[0]);
                  end), v));
end

var hash = Hashtbl.hash;

function equal(x, y) do
  return x == y;
end

var Int_hash = Hashtbl.Make(do
      equal: equal,
      hash: hash
    end);

var suites_000 = --[ tuple ]--[
  "simple",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                --[ :: ]--[
                  --[ tuple ]--[
                    1,
                    --[ "1" ]--49
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      2,
                      --[ "2" ]--50
                    ],
                    --[ [] ]--0
                  ]
                ],
                f(Int_hash)
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "more_iterations",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  $$Array.init(1001, (function (i) do
                          return --[ tuple ]--[
                                  (i << 1),
                                  String(i)
                                ];
                        end)),
                  g(Int_hash, 1000)
                ]);
      end)
  ],
  --[ [] ]--0
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Int_hashtbl_test", suites);

exports.f = f;
exports.g = g;
exports.Int_hash = Int_hash;
exports.suites = suites;
--[ Int_hash Not a pure module ]--
