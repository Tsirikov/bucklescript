--[['use strict';]]

Mt = require "./mt";
Block = require "../../lib/js/block";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

(function (n) do
      return 0;
    end end)((function (q, y) do
        return false;
      end end)) == 0;

eq("File \"gpr_1667_test.ml\", line 18, characters 7-14", 0, 0);

Mt.from_pair_suites("Gpr_1667_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
