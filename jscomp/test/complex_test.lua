console.log = print;

Mt = require "./mt";
Block = require "../../lib/js/block";
Complex = require "../../lib/js/complex";

suites_000 = --[[ tuple ]]{
  "basic_add",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                do
                  re: 2,
                  im: 2
                end,
                Complex.add(Complex.add(Complex.add(Complex.one, Complex.one), Complex.i), Complex.i)
              });
    end end)
};

suites = --[[ :: ]]{
  suites_000,
  --[[ [] ]]0
};

Mt.from_pair_suites("Complex_test", suites);

exports.suites = suites;
--[[  Not a pure module ]]
