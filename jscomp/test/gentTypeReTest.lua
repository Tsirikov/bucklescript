--[['use strict';]]

GentTypeReTestGen = require "./gentTypeReTest";

function f(prim) do
  return GentTypeReTestGen.f(prim);
end end

exports.f = f;
--[[ ./gentTypeReTest.gen Not a pure module ]]
