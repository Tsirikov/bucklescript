--[['use strict';]]

__Buffer = require "../../lib/js/buffer.lua";

foo = __Buffer.contents;

function bar(str) do
  return Buffer.from(str);
end end

exports.foo = foo;
exports.bar = bar;
--[[ No side effect ]]