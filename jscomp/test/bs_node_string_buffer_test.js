'use strict';

var $$Node = require("../../lib/js/node.js");

function f(str) do
  var match = $$Node.test(str);
  if (match[0]) do
    console.log(--[ tuple ]--[
          "buffer",
          Buffer.isBuffer(match[1])
        ]);
    return --[ () ]--0;
  end else do
    console.log(--[ tuple ]--[
          "string",
          match[1]
        ]);
    return --[ () ]--0;
  end
end

f("xx");

f((Buffer.from ('xx')));

exports.f = f;
--[  Not a pure module ]--
