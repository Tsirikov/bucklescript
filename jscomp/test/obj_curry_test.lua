--[['use strict';]]

Caml_oo_curry = require "../../lib/js/caml_oo_curry.lua";
CamlinternalOO = require "../../lib/js/camlinternalOO.lua";

function f(o) do
  return Caml_oo_curry.js4(23297, 1, o, 1, 2, 3);
end end

__class = CamlinternalOO.create_table(["hi"]);

hi = CamlinternalOO.get_method_label(__class, "hi");

a = f((CamlinternalOO.set_method(__class, hi, (function (self$1, x, y, z) do
              return (x + y | 0) + z | 0;
            end end)), CamlinternalOO.init_class(__class), CamlinternalOO.create_object_opt(0, __class)));

exports.f = f;
exports.a = a;
--[[ a Not a pure module ]]