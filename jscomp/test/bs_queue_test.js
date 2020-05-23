'use strict';

var Mt = require("./mt.js");
var Curry = require("../../lib/js/curry.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Belt_Array = require("../../lib/js/belt_Array.js");
var Belt_MutableQueue = require("../../lib/js/belt_MutableQueue.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end

function does_raise(f, q) do
  try do
    Curry._1(f, q);
    return false;
  end
  catch (exn)do
    return true;
  end
end

function $plus$plus(q, x) do
  Belt_MutableQueue.add(q, x);
  return q;
end

var q = Belt_MutableQueue.make(--[ () ]--0);

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), []) and q.length == 0)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          21,
          2
        ]
      ];
end

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray((Belt_MutableQueue.add(q, 1), q)), [1]) and q.length == 1)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          22,
          2
        ]
      ];
end

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray((Belt_MutableQueue.add(q, 2), q)), [
          1,
          2
        ]) and q.length == 2)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          23,
          2
        ]
      ];
end

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray((Belt_MutableQueue.add(q, 3), q)), [
          1,
          2,
          3
        ]) and q.length == 3)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          24,
          2
        ]
      ];
end

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray((Belt_MutableQueue.add(q, 4), q)), [
          1,
          2,
          3,
          4
        ]) and q.length == 4)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          25,
          2
        ]
      ];
end

if (Belt_MutableQueue.popExn(q) ~= 1) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          26,
          2
        ]
      ];
end

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), [
          2,
          3,
          4
        ]) and q.length == 3)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          26,
          27
        ]
      ];
end

if (Belt_MutableQueue.popExn(q) ~= 2) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          27,
          2
        ]
      ];
end

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), [
          3,
          4
        ]) and q.length == 2)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          27,
          27
        ]
      ];
end

if (Belt_MutableQueue.popExn(q) ~= 3) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          28,
          2
        ]
      ];
end

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), [4]) and q.length == 1)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          28,
          27
        ]
      ];
end

if (Belt_MutableQueue.popExn(q) ~= 4) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          29,
          2
        ]
      ];
end

if (!(Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), []) and q.length == 0)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          29,
          27
        ]
      ];
end

if (!does_raise(Belt_MutableQueue.popExn, q)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          30,
          2
        ]
      ];
end

var q$1 = Belt_MutableQueue.make(--[ () ]--0);

if (Belt_MutableQueue.popExn((Belt_MutableQueue.add(q$1, 1), q$1)) ~= 1) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          35,
          2
        ]
      ];
end

if (!does_raise(Belt_MutableQueue.popExn, q$1)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          35,
          34
        ]
      ];
end

if (Belt_MutableQueue.popExn((Belt_MutableQueue.add(q$1, 2), q$1)) ~= 2) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          36,
          2
        ]
      ];
end

if (!does_raise(Belt_MutableQueue.popExn, q$1)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          36,
          34
        ]
      ];
end

if (q$1.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          37,
          2
        ]
      ];
end

var q$2 = Belt_MutableQueue.make(--[ () ]--0);

if (Belt_MutableQueue.peekExn((Belt_MutableQueue.add(q$2, 1), q$2)) ~= 1) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          42,
          2
        ]
      ];
end

if (Belt_MutableQueue.peekExn((Belt_MutableQueue.add(q$2, 2), q$2)) ~= 1) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          43,
          2
        ]
      ];
end

if (Belt_MutableQueue.peekExn((Belt_MutableQueue.add(q$2, 3), q$2)) ~= 1) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          44,
          2
        ]
      ];
end

if (Belt_MutableQueue.peekExn(q$2) ~= 1) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          45,
          2
        ]
      ];
end

if (Belt_MutableQueue.popExn(q$2) ~= 1) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          45,
          28
        ]
      ];
end

if (Belt_MutableQueue.peekExn(q$2) ~= 2) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          46,
          2
        ]
      ];
end

if (Belt_MutableQueue.popExn(q$2) ~= 2) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          46,
          28
        ]
      ];
end

if (Belt_MutableQueue.peekExn(q$2) ~= 3) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          47,
          2
        ]
      ];
end

if (Belt_MutableQueue.popExn(q$2) ~= 3) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          47,
          28
        ]
      ];
end

if (!does_raise(Belt_MutableQueue.peekExn, q$2)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          48,
          2
        ]
      ];
end

if (!does_raise(Belt_MutableQueue.peekExn, q$2)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          49,
          2
        ]
      ];
end

var q$3 = Belt_MutableQueue.make(--[ () ]--0);

for(var i = 1; i <= 10; ++i)do
  Belt_MutableQueue.add(q$3, i);
end

Belt_MutableQueue.clear(q$3);

if (q$3.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          56,
          2
        ]
      ];
end

if (!does_raise(Belt_MutableQueue.popExn, q$3)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          57,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(q$3, Belt_MutableQueue.make(--[ () ]--0))) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          58,
          2
        ]
      ];
end

Belt_MutableQueue.add(q$3, 42);

if (Belt_MutableQueue.popExn(q$3) ~= 42) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          60,
          2
        ]
      ];
end

var q1 = Belt_MutableQueue.make(--[ () ]--0);

for(var i$1 = 1; i$1 <= 10; ++i$1)do
  Belt_MutableQueue.add(q1, i$1);
end

var q2 = Belt_MutableQueue.copy(q1);

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1), [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          67,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2), [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          68,
          2
        ]
      ];
end

if (q1.length ~= 10) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          69,
          2
        ]
      ];
end

if (q2.length ~= 10) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          70,
          2
        ]
      ];
end

for(var i$2 = 1; i$2 <= 10; ++i$2)do
  if (Belt_MutableQueue.popExn(q1) ~= i$2) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_queue_test.ml",
            72,
            4
          ]
        ];
  end
  
end

for(var i$3 = 1; i$3 <= 10; ++i$3)do
  if (Belt_MutableQueue.popExn(q2) ~= i$3) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_queue_test.ml",
            75,
            4
          ]
        ];
  end
  
end

var q$4 = Belt_MutableQueue.make(--[ () ]--0);

if (q$4.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          81,
          2
        ]
      ];
end

for(var i$4 = 1; i$4 <= 10; ++i$4)do
  Belt_MutableQueue.add(q$4, i$4);
  if (q$4.length ~= i$4) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_queue_test.ml",
            84,
            4
          ]
        ];
  end
  if (q$4.length == 0) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_queue_test.ml",
            85,
            4
          ]
        ];
  end
  
end

for(var i$5 = 10; i$5 >= 1; --i$5)do
  if (q$4.length ~= i$5) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_queue_test.ml",
            88,
            4
          ]
        ];
  end
  if (q$4.length == 0) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_queue_test.ml",
            89,
            4
          ]
        ];
  end
  Belt_MutableQueue.popExn(q$4);
end

if (q$4.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          92,
          2
        ]
      ];
end

if (q$4.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          93,
          2
        ]
      ];
end

var q$5 = Belt_MutableQueue.make(--[ () ]--0);

for(var i$6 = 1; i$6 <= 10; ++i$6)do
  Belt_MutableQueue.add(q$5, i$6);
end

var i$7 = do
  contents: 1
end;

Belt_MutableQueue.forEach(q$5, (function (j) do
        if (i$7.contents ~= j) do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "bs_queue_test.ml",
                  100,
                  24
                ]
              ];
        end
        i$7.contents = i$7.contents + 1 | 0;
        return --[ () ]--0;
      end));

var q1$1 = Belt_MutableQueue.make(--[ () ]--0);

var q2$1 = Belt_MutableQueue.make(--[ () ]--0);

if (q1$1.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          105,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1$1), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          105,
          26
        ]
      ];
end

if (q2$1.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          106,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2$1), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          106,
          26
        ]
      ];
end

Belt_MutableQueue.transfer(q1$1, q2$1);

if (q1$1.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          108,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1$1), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          108,
          26
        ]
      ];
end

if (q2$1.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          109,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2$1), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          109,
          26
        ]
      ];
end

var q1$2 = Belt_MutableQueue.make(--[ () ]--0);

var q2$2 = Belt_MutableQueue.make(--[ () ]--0);

for(var i$8 = 1; i$8 <= 4; ++i$8)do
  Belt_MutableQueue.add(q1$2, i$8);
end

if (q1$2.length ~= 4) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          115,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1$2), [
        1,
        2,
        3,
        4
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          115,
          26
        ]
      ];
end

if (q2$2.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          116,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2$2), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          116,
          26
        ]
      ];
end

Belt_MutableQueue.transfer(q1$2, q2$2);

if (q1$2.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          118,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1$2), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          118,
          26
        ]
      ];
end

if (q2$2.length ~= 4) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          119,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2$2), [
        1,
        2,
        3,
        4
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          119,
          26
        ]
      ];
end

var q1$3 = Belt_MutableQueue.make(--[ () ]--0);

var q2$3 = Belt_MutableQueue.make(--[ () ]--0);

for(var i$9 = 5; i$9 <= 8; ++i$9)do
  Belt_MutableQueue.add(q2$3, i$9);
end

if (q1$3.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          125,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1$3), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          125,
          26
        ]
      ];
end

if (q2$3.length ~= 4) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          126,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2$3), [
        5,
        6,
        7,
        8
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          126,
          26
        ]
      ];
end

Belt_MutableQueue.transfer(q1$3, q2$3);

if (q1$3.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          128,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1$3), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          128,
          26
        ]
      ];
end

if (q2$3.length ~= 4) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          129,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2$3), [
        5,
        6,
        7,
        8
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          129,
          26
        ]
      ];
end

var q1$4 = Belt_MutableQueue.make(--[ () ]--0);

var q2$4 = Belt_MutableQueue.make(--[ () ]--0);

for(var i$10 = 1; i$10 <= 4; ++i$10)do
  Belt_MutableQueue.add(q1$4, i$10);
end

for(var i$11 = 5; i$11 <= 8; ++i$11)do
  Belt_MutableQueue.add(q2$4, i$11);
end

if (q1$4.length ~= 4) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          136,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1$4), [
        1,
        2,
        3,
        4
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          136,
          26
        ]
      ];
end

if (q2$4.length ~= 4) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          137,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2$4), [
        5,
        6,
        7,
        8
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          137,
          26
        ]
      ];
end

Belt_MutableQueue.transfer(q1$4, q2$4);

if (q1$4.length ~= 0) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          139,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1$4), [])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          139,
          26
        ]
      ];
end

var v = [
  5,
  6,
  7,
  8,
  1,
  2,
  3,
  4
];

if (q2$4.length ~= 8) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          141,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2$4), v)) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          141,
          26
        ]
      ];
end

if (Belt_MutableQueue.reduce(q2$4, 0, (function (x, y) do
          return x - y | 0;
        end)) ~= Belt_Array.reduce(v, 0, (function (x, y) do
          return x - y | 0;
        end))) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "bs_queue_test.ml",
          143,
          2
        ]
      ];
end

console.log("OK");

var q$6 = Belt_MutableQueue.fromArray([
      1,
      2,
      3,
      4
    ]);

var q1$5 = Belt_MutableQueue.map(q$6, (function (x) do
        return x - 1 | 0;
      end));

eq("File \"bs_queue_test.ml\", line 154, characters 5-12", Belt_MutableQueue.toArray(q1$5), [
      0,
      1,
      2,
      3
    ]);

var q$7 = Belt_MutableQueue.fromArray([]);

b("File \"bs_queue_test.ml\", line 155, characters 4-11", q$7.length == 0);

var q$8 = Belt_MutableQueue.map(Belt_MutableQueue.fromArray([]), (function (x) do
        return x + 1 | 0;
      end));

b("File \"bs_queue_test.ml\", line 156, characters 4-11", q$8.length == 0);

Mt.from_pair_suites("Bs_queue_test", suites.contents);

var Q = --[ alias ]--0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.Q = Q;
exports.does_raise = does_raise;
exports.$plus$plus = $plus$plus;
--[ q Not a pure module ]--
