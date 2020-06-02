console.log = print;

Mt = require "./mt";
Belt_Id = require "../../lib/js/belt_Id";
Hashtbl = require "../../lib/js/hashtbl";
Belt_Array = require "../../lib/js/belt_Array";
Belt_HashMap = require "../../lib/js/belt_HashMap";
Belt_SortArray = require "../../lib/js/belt_SortArray";
Caml_primitive = require "../../lib/js/caml_primitive";
Array_data_util = require "./array_data_util";
Belt_internalBucketsType = require "../../lib/js/belt_internalBucketsType";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eqx(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

function eq(x, y) do
  return x == y;
end end

hash = Hashtbl.hash;

cmp = Caml_primitive.caml_int_compare;

Y = Belt_Id.hashable(hash, eq);

empty = Belt_internalBucketsType.make(Y.hash, Y.eq, 30);

function add(prim, prim_1) do
  return prim + prim_1 | 0;
end end

Belt_HashMap.mergeMany(empty, {
      --[[ tuple ]]{
        1,
        1
      },
      --[[ tuple ]]{
        2,
        3
      },
      --[[ tuple ]]{
        3,
        3
      },
      --[[ tuple ]]{
        2,
        2
      }
    });

eqx("File \"bs_hashmap_test.ml\", line 31, characters 6-13", Belt_HashMap.get(empty, 2), 2);

eqx("File \"bs_hashmap_test.ml\", line 32, characters 6-13", empty.size, 3);

u = Belt_Array.concat(Array_data_util.randomRange(30, 100), Array_data_util.randomRange(40, 120));

v = Belt_Array.zip(u, u);

xx = Belt_HashMap.fromArray(v, Y);

eqx("File \"bs_hashmap_test.ml\", line 41, characters 6-13", xx.size, 91);

eqx("File \"bs_hashmap_test.ml\", line 42, characters 6-13", Belt_SortArray.stableSortBy(Belt_HashMap.keysToArray(xx), cmp), Array_data_util.range(30, 120));

u_1 = Belt_Array.concat(Array_data_util.randomRange(0, 100000), Array_data_util.randomRange(0, 100));

v_1 = Belt_internalBucketsType.make(Y.hash, Y.eq, 40);

Belt_HashMap.mergeMany(v_1, Belt_Array.zip(u_1, u_1));

eqx("File \"bs_hashmap_test.ml\", line 48, characters 6-13", v_1.size, 100001);

for i = 0 , 1000 , 1 do
  Belt_HashMap.remove(v_1, i);
end

eqx("File \"bs_hashmap_test.ml\", line 52, characters 6-13", v_1.size, 99000);

for i_1 = 0 , 2000 , 1 do
  Belt_HashMap.remove(v_1, i_1);
end

eqx("File \"bs_hashmap_test.ml\", line 56, characters 6-13", v_1.size, 98000);

b("File \"bs_hashmap_test.ml\", line 57, characters 4-11", Belt_Array.every(Array_data_util.range(2001, 100000), (function (x) do
            return Belt_HashMap.has(v_1, x);
          end end)));

Mt.from_pair_suites("Bs_hashmap_test", suites.contents);

N = --[[ alias ]]0;

S = --[[ alias ]]0;

I = --[[ alias ]]0;

$plus$plus = Belt_Array.concat;

A = --[[ alias ]]0;

So = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eqx = eqx;
exports.b = b;
exports.N = N;
exports.S = S;
exports.eq = eq;
exports.hash = hash;
exports.cmp = cmp;
exports.Y = Y;
exports.empty = empty;
exports.I = I;
exports.$plus$plus = $plus$plus;
exports.add = add;
exports.A = A;
exports.So = So;
--[[ Y Not a pure module ]]
