'use strict';


function test(x) do
  x.nodeValue = null;
  return --[ () ]--0;
end

exports.test = test;
--[ No side effect ]--
