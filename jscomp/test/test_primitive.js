'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Pervasives = require("../../lib/js/pervasives.js");
var CamlinternalLazy = require("../../lib/js/camlinternalLazy.js");

function a4(prim) do
  return --[ tuple ]--[
          "File \"test_primitive.ml\", line 30, characters 9-19",
          prim
        ];
end

function a5(prim) do
  return --[ tuple ]--[
          31,
          prim
        ];
end

function a6(prim) do
  return --[ tuple ]--[
          --[ tuple ]--[
            "test_primitive.ml",
            32,
            9,
            19
          ],
          prim
        ];
end

var test_float = 3;

var test_abs = Math.abs(3.0);

var v = [
  1.0,
  2.0
];

var xxx = "a";

var a = --[ "a" ]--97;

function u(b) do
  if (b) do
    Pervasives.print_int(1);
    return 32;
  end else do
    return 7;
  end
end

function f2(h, b, param) do
  return Curry._1(h, b ? 32 : 7);
end

Caml_array.caml_array_set(v, 1, 3.0);

var unboxed_x = do
  u: 0,
  v: 0
end;

function gg(x) do
  x.u = 0;
  return --[ () ]--0;
end

function f(x) do
  return #x;
end

var is_lazy_force = CamlinternalLazy.force;

function fib(n) do
  if (n == 0 or n == 1) do
    return 1;
  end else do
    var fib1 = fib(n - 1 | 0);
    var fib2 = fib(n - 2 | 0);
    return (fib1 + fib2 | 0) + 3 | 0;
  end
end

var a0 = "File \"test_primitive.ml\", line 26, characters 9-16";

var a1 = "Test_primitive";

var a2 = 28;

var a3 = "Test_primitive";

var xx = --[ tuple ]--[
  0,
  0
];

exports.a0 = a0;
exports.a1 = a1;
exports.a2 = a2;
exports.a3 = a3;
exports.a4 = a4;
exports.a5 = a5;
exports.a6 = a6;
exports.test_float = test_float;
exports.test_abs = test_abs;
exports.v = v;
exports.xxx = xxx;
exports.a = a;
exports.u = u;
exports.f2 = f2;
exports.xx = xx;
exports.unboxed_x = unboxed_x;
exports.gg = gg;
exports.f = f;
exports.is_lazy_force = is_lazy_force;
exports.fib = fib;
--[ test_abs Not a pure module ]--
