'use strict';


function to_unsgined(x) do
  return (x >>> 0);
end

function f(x) do
  return (x >>> 0);
end

function ff(x) do
  return (x >>> 0);
end

function fff(x) do
  return 3 + (3 + (4 + (1 + x)));
end

exports.to_unsgined = to_unsgined;
exports.f = f;
exports.ff = ff;
exports.fff = fff;
--[ No side effect ]--
