'use strict';

var Mt = require("./mt.js");
var Caml_external_polyfill = require("../../lib/js/caml_external_polyfill.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

require('../../lib/js/caml_external_polyfill.js').register("caml_fancy_add", function(x,y){
  return + ((""+x ) + (""+y))
})
;

var h = Caml_external_polyfill.resolve("caml_fancy_add")(1, 2);

eq("File \"external_polyfill_test.ml\", line 19, characters 5-12", h, 12);

Mt.from_pair_suites("External_polyfill_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.h = h;
--[  Not a pure module ]--
