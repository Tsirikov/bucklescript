'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Scanf = require("../../lib/js/scanf.js");
var Mt_global = require("./mt_global.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(f, param) do
  return Mt_global.collect_eq(test_id, suites, f, param[0], param[1]);
end

eq("File \"scanf_test.ml\", line 6, characters 5-12", --[ tuple ]--[
      Curry._1(Scanf.sscanf("32 31", --[ Format ]--[
                --[ Int ]--Block.__(4, [
                    --[ Int_d ]--0,
                    --[ No_padding ]--0,
                    --[ No_precision ]--0,
                    --[ Char_literal ]--Block.__(12, [
                        --[ " " ]--32,
                        --[ Int ]--Block.__(4, [
                            --[ Int_d ]--0,
                            --[ No_padding ]--0,
                            --[ No_precision ]--0,
                            --[ End_of_format ]--0
                          ])
                      ])
                  ]),
                "%d %d"
              ]), (function (x, y) do
              return x + y | 0;
            end)),
      63
    ]);

eq("File \"scanf_test.ml\", line 7, characters 5-12", --[ tuple ]--[
      Curry._1(Scanf.sscanf("12306459064359371967", --[ Format ]--[
                --[ Int64 ]--Block.__(7, [
                    --[ Int_u ]--12,
                    --[ No_padding ]--0,
                    --[ No_precision ]--0,
                    --[ End_of_format ]--0
                  ]),
                "%Lu"
              ]), (function (i) do
              return i;
            end)),
      --[ int64 ]--[
        --[ hi ]---1429646511,
        --[ lo ]--235324607
      ]
    ]);

Mt.from_pair_suites("Scanf_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[  Not a pure module ]--
