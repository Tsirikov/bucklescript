console.log = print;

Mt = require "./mt";
Block = require "../../lib/js/block";

v = do
  contents: 1
end;

v.contents = v.contents + 1 | 0;

a = v.contents;

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

eq("File \"condition_compilation_test.ml\", line 98, characters 5-12", 3, 3);

eq("File \"condition_compilation_test.ml\", line 99, characters 5-12", v.contents, 2);

Mt.from_pair_suites("Condition_compilation_test", suites.contents);

b = "u";

buffer_size = 1;

vv = 3;

version_gt_3 = true;

version = -1;

ocaml_veriosn = "unknown";

exports.b = b;
exports.buffer_size = buffer_size;
exports.vv = vv;
exports.v = v;
exports.a = a;
exports.version_gt_3 = version_gt_3;
exports.version = version;
exports.ocaml_veriosn = ocaml_veriosn;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
