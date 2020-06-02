console.log = print;

Mt = require "./mt";
Char = require "../../lib/js/char";
__Array = require "../../lib/js/array";
Bytes = require "../../lib/js/bytes";
Hashtbl = require "../../lib/js/hashtbl";
Mt_global = require "./mt_global";
Caml_bytes = require "../../lib/js/caml_bytes";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(f) do
  return (function (param, param_1) do
      return Mt_global.collect_eq(test_id, suites, f, param, param_1);
    end end);
end end

test_strings = __Array.init(32, (function (i) do
        c = Char.chr(i);
        return Caml_bytes.bytes_to_string(Bytes.make(i, c));
      end end));

test_strings_hash_results = {
  0,
  904391063,
  889600889,
  929588010,
  596566298,
  365199070,
  448044845,
  311625091,
  681445541,
  634941451,
  82108334,
  17482990,
  491949228,
  696194769,
  711728152,
  594966620,
  820561748,
  958901713,
  102794744,
  378848504,
  349314368,
  114167579,
  71240932,
  110067399,
  280623927,
  323523937,
  310683234,
  178511779,
  585018975,
  544388424,
  1043872806,
  831138595
};

function normalize(x) do
  return x & 1073741823;
end end

function caml_hash(x) do
  return Hashtbl.hash(x) & 1073741823;
end end

param = __Array.map(caml_hash, test_strings);

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 18, characters 5-12", param, test_strings_hash_results);

param_1 = Hashtbl.hash(0) & 1073741823;

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 24, characters 5-12", param_1, 129913994);

param_2 = Hashtbl.hash("x") & 1073741823;

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 27, characters 5-12", param_2, 780510073);

param_3 = Hashtbl.hash("xy") & 1073741823;

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 30, characters 5-12", param_3, 194127723);

param_4 = Hashtbl.hash(--[[ A ]]65) & 1073741823;

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 33, characters 5-12", param_4, 381663642);

param_5 = Hashtbl.hash(--[[ `A ]]{
      65,
      3
    }) & 1073741823;

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 34, characters 5-12", param_5, 294279345);

param_6 = Hashtbl.hash(--[[ :: ]]{
      --[[ `A ]]{
        65,
        3
      },
      --[[ :: ]]{
        --[[ `B ]]{
          66,
          2
        },
        --[[ :: ]]{
          --[[ `C ]]{
            67,
            3
          },
          --[[ [] ]]0
        }
      }
    }) & 1073741823;

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 35, characters 5-12", param_6, 1017654909);

param_7 = Hashtbl.hash(--[[ :: ]]{
      --[[ tuple ]]{
        --[[ `A ]]{
          65,
          "3"
        },
        --[[ `B ]]{
          66,
          "2"
        }
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          --[[ `C ]]{
            67,
            "3"
          },
          --[[ `D ]]{
            68,
            "4"
          }
        },
        --[[ [] ]]0
      }
    }) & 1073741823;

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 36, characters 5-12", param_7, 81986873);

param_8 = Hashtbl.hash(--[[ :: ]]{
      --[[ tuple ]]{
        --[[ `A ]]{
          65,
          --[[ tuple ]]{
            0,
            2,
            1
          }
        },
        --[[ `B ]]{
          66,
          {--[[ tuple ]]{
              "x",
              "y"
            }}
        }
      },
      --[[ [] ]]0
    }) & 1073741823;

Mt_global.collect_eq(test_id, suites, "File \"hash_test.ml\", line 39, characters 5-12", param_8, 100650590);

Mt.from_pair_suites("Hash_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.test_strings = test_strings;
exports.test_strings_hash_results = test_strings_hash_results;
exports.normalize = normalize;
exports.caml_hash = caml_hash;
--[[ test_strings Not a pure module ]]
