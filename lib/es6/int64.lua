

import * as Caml_int64 from "./caml_int64.lua";
import * as Caml_format from "./caml_format.lua";
import * as Caml_js_exceptions from "./caml_js_exceptions.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function succ(n) do
  return Caml_int64.add(n, --[[ int64 ]]{
              --[[ hi ]]0,
              --[[ lo ]]1
            });
end end

function pred(n) do
  return Caml_int64.sub(n, --[[ int64 ]]{
              --[[ hi ]]0,
              --[[ lo ]]1
            });
end end

function abs(n) do
  if (Caml_int64.ge(n, --[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]0
        })) then do
    return n;
  end else do
    return Caml_int64.neg(n);
  end end 
end end

function lognot(n) do
  return Caml_int64.xor(n, --[[ int64 ]]{
              --[[ hi ]]-1,
              --[[ lo ]]4294967295
            });
end end

function to_string(n) do
  return Caml_format.caml_int64_format("%d", n);
end end

function of_string_opt(s) do
  xpcall(function() do
    return Caml_format.caml_int64_of_string(s);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      error (exn)
    end end 
  end end)
end end

compare = Caml_int64.compare;

function equal(x, y) do
  return Caml_int64.compare(x, y) == 0;
end end

zero = --[[ int64 ]]{
  --[[ hi ]]0,
  --[[ lo ]]0
};

one = --[[ int64 ]]{
  --[[ hi ]]0,
  --[[ lo ]]1
};

minus_one = --[[ int64 ]]{
  --[[ hi ]]-1,
  --[[ lo ]]4294967295
};

max_int = --[[ int64 ]]{
  --[[ hi ]]2147483647,
  --[[ lo ]]4294967295
};

min_int = --[[ int64 ]]{
  --[[ hi ]]-2147483648,
  --[[ lo ]]0
};

export do
  zero ,
  one ,
  minus_one ,
  succ ,
  pred ,
  abs ,
  max_int ,
  min_int ,
  lognot ,
  of_string_opt ,
  to_string ,
  compare ,
  equal ,
  
end
--[[ No side effect ]]
