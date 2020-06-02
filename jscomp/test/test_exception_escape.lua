--[['use strict';]]

Caml_exceptions = require "../../lib/js/caml_exceptions";

A = Caml_exceptions.create("Test_exception_escape.N.A");

f;

xpcall(function() do
  error({
    A,
    3
  })
end end,function(exn) do
  f = 3;
end end)

N = do
  f: f
end;

exports.N = N;
--[[ f Not a pure module ]]
