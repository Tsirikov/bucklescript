--[['use strict';]]

Caml_int64 = require "./caml_int64.lua";
Caml_format = require "./caml_format.lua";
Caml_js_exceptions = require "./caml_js_exceptions.lua";
Caml_builtin_exceptions = require "./caml_builtin_exceptions.lua";

function succ(n) do
  return Caml_int64.add(n, --[[ int64 ]][
              --[[ hi ]]0,
              --[[ lo ]]1
            ]);
end end

function pred(n) do
  return Caml_int64.sub(n, --[[ int64 ]][
              --[[ hi ]]0,
              --[[ lo ]]1
            ]);
end end

function abs(n) do
  if (Caml_int64.ge(n, --[[ int64 ]][
          --[[ hi ]]0,
          --[[ lo ]]0
        ])) then do
    return n;
  end else do
    return Caml_int64.neg(n);
  end end 
end end

function lognot(n) do
  return Caml_int64.xor(n, --[[ int64 ]][
              --[[ hi ]]-1,
              --[[ lo ]]4294967295
            ]);
end end

function to_string(n) do
  return Caml_format.caml_int64_format("%d", n);
end end

function of_string_opt(s) do
  try do
    return Caml_format.caml_int64_of_string(s);
  end
  catch (raw_exn)do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      throw exn;
    end end 
  end
end end

compare = Caml_int64.compare;

function equal(x, y) do
  return Caml_int64.compare(x, y) == 0;
end end

zero = --[[ int64 ]][
  --[[ hi ]]0,
  --[[ lo ]]0
];

one = --[[ int64 ]][
  --[[ hi ]]0,
  --[[ lo ]]1
];

minus_one = --[[ int64 ]][
  --[[ hi ]]-1,
  --[[ lo ]]4294967295
];

max_int = --[[ int64 ]][
  --[[ hi ]]2147483647,
  --[[ lo ]]4294967295
];

min_int = --[[ int64 ]][
  --[[ hi ]]-2147483648,
  --[[ lo ]]0
];

exports.zero = zero;
exports.one = one;
exports.minus_one = minus_one;
exports.succ = succ;
exports.pred = pred;
exports.abs = abs;
exports.max_int = max_int;
exports.min_int = min_int;
exports.lognot = lognot;
exports.of_string_opt = of_string_opt;
exports.to_string = to_string;
exports.compare = compare;
exports.equal = equal;
--[[ No side effect ]]