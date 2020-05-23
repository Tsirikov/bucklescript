'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

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

function add(x,y){
  return x + y
}
;

var v = do
  contents: 0
end;

var h = (v.contents = v.contents + 1 | 0, do
    hi: 2,
    lo: 0
  end);

var z = (v.contents = v.contents + 1 | 0, add(3.0, 2.0));

eq("File \"bs_ignore_effect.ml\", line 26, characters 5-12", v.contents, 2);

eq("File \"bs_ignore_effect.ml\", line 27, characters 5-12", z, 5.0);

Mt.from_pair_suites("Bs_ignore_effect", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.h = h;
exports.z = z;
--[  Not a pure module ]--
