'use strict';

Caml_exceptions = require("../../lib/js/caml_exceptions.lua");

A = Caml_exceptions.create("Rebind_module.A");

AA = Caml_exceptions.create("Rebind_module.AA");

exports.A = A;
exports.AA = AA;
--[[ No side effect ]]
