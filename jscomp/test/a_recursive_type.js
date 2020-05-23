'use strict';

var Curry = require("../../lib/js/curry.js");

function g(x) do
  return Curry._1(x[0], x);
end

var loop = g(--[ A ]--[g]);

var x = --[ A ]--[g];

var non_terminate = g(x);

exports.loop = loop;
exports.non_terminate = non_terminate;
--[ loop Not a pure module ]--
