--[['use strict';]]


function f(x) do
  x.pushState(3, "x");
  return x.pushState(undefined, "x");
end end

exports.f = f;
--[[ No side effect ]]