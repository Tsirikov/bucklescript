console.log = print;

Caml_exceptions = require "../../lib/js/caml_exceptions";

U = Caml_exceptions.create("Test_common.U");

H = Caml_exceptions.create("Test_common.H");

exports.U = U;
exports.H = H;
--[[ No side effect ]]
