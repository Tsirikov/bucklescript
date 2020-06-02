--[['use strict';]]

Caml_format = require "./caml_format.lua";
Caml_primitive = require "./caml_primitive.lua";
Caml_builtin_exceptions = require "./caml_builtin_exceptions.lua";

function err_not_sv(i) do
  return Caml_format.caml_format_int("%X", i) .. " is not an Unicode scalar value";
end end

function err_not_latin1(u) do
  return "U+" .. (Caml_format.caml_format_int("%04X", u) .. " is not a latin1 character");
end end

function succ(u) do
  if (u == 55295) then do
    return 57344;
  end else do
    if (u == 1114111) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "U+10FFFF has no successor"
          ];
    end
     end 
    return u + 1 | 0;
  end end 
end end

function pred(u) do
  if (u == 57344) then do
    return 55295;
  end else do
    if (u == 0) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "U+0000 has no predecessor"
          ];
    end
     end 
    return u - 1 | 0;
  end end 
end end

function is_valid(i) do
  if (0 <= i and i <= 55295) then do
    return true;
  end else if (57344 <= i) then do
    return i <= 1114111;
  end else do
    return false;
  end end  end 
end end

function of_int(i) do
  if (is_valid(i)) then do
    return i;
  end else do
    s = err_not_sv(i);
    throw [
          Caml_builtin_exceptions.invalid_argument,
          s
        ];
  end end 
end end

function is_char(u) do
  return u < 256;
end end

function of_char(c) do
  return c;
end end

function to_char(u) do
  if (u > 255) then do
    s = err_not_latin1(u);
    throw [
          Caml_builtin_exceptions.invalid_argument,
          s
        ];
  end else do
    return u;
  end end 
end end

function unsafe_to_char(prim) do
  return prim;
end end

function equal(prim, prim$1) do
  return prim == prim$1;
end end

compare = Caml_primitive.caml_int_compare;

function hash(prim) do
  return prim;
end end

min = 0;

max = 1114111;

bom = 65279;

rep = 65533;

function unsafe_of_int(prim) do
  return prim;
end end

function to_int(prim) do
  return prim;
end end

exports.min = min;
exports.max = max;
exports.bom = bom;
exports.rep = rep;
exports.succ = succ;
exports.pred = pred;
exports.is_valid = is_valid;
exports.of_int = of_int;
exports.unsafe_of_int = unsafe_of_int;
exports.to_int = to_int;
exports.is_char = is_char;
exports.of_char = of_char;
exports.to_char = to_char;
exports.unsafe_to_char = unsafe_to_char;
exports.equal = equal;
exports.compare = compare;
exports.hash = hash;
--[[ No side effect ]]