console = {log = print};


v = {
  x = (function() do
      return 3; end
    end),
  say = (function(x) do
      self = this ;
      return self.x() + x | 0; end
    end)
};

u = v.x() + v.say(3) | 0;

exports = {}
exports.v = v;
exports.u = u;
--[[ v Not a pure module ]]
