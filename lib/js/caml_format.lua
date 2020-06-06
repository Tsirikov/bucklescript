console = {log = print};

Caml_int32 = require "./caml_int32";
Caml_int64 = require "./caml_int64";
Caml_utils = require "./caml_utils";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

function parse_digit(c) do
  if (c >= 65) then do
    if (c >= 97) then do
      if (c >= 123) then do
        return -1;
      end else do
        return c - 87 | 0;
      end end 
    end else if (c >= 91) then do
      return -1;
    end else do
      return c - 55 | 0;
    end end  end 
  end else if (c > 57 or c < 48) then do
    return -1;
  end else do
    return c - --[[ "0" ]]48 | 0;
  end end  end 
end end

function int_of_string_base(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ == 0--[[ Oct ]] then do
        return 8; end end 
     if ___conditional___ == 1--[[ Hex ]] then do
        return 16; end end 
     if ___conditional___ == 2--[[ Dec ]] then do
        return 10; end end 
     if ___conditional___ == 3--[[ Bin ]] then do
        return 2; end end 
    
  end
end end

function parse_sign_and_base(s) do
  sign = 1;
  base = --[[ Dec ]]2;
  i = 0;
  match = s.charCodeAt(i);
  local ___conditional___=(match);
  do
     if ___conditional___ == 43 then do
        i = i + 1 | 0; end else 
     if ___conditional___ == 44
     or ___conditional___ == 45 then do
        sign = -1;
        i = i + 1 | 0; end else 
     end end end end
    
  end
  if (s[i] == "0") then do
    match_1 = s.charCodeAt(i + 1 | 0);
    if (match_1 >= 89) then do
      if (match_1 >= 111) then do
        if (match_1 < 121) then do
          local ___conditional___=(match_1 - 111 | 0);
          do
             if ___conditional___ == 0 then do
                base = --[[ Oct ]]0;
                i = i + 2 | 0; end else 
             if ___conditional___ == 6 then do
                i = i + 2 | 0; end else 
             if ___conditional___ == 1
             or ___conditional___ == 2
             or ___conditional___ == 3
             or ___conditional___ == 4
             or ___conditional___ == 5
             or ___conditional___ == 7
             or ___conditional___ == 8
             or ___conditional___ == 9 then do
                base = --[[ Hex ]]1;
                i = i + 2 | 0; end else 
             end end end end end end
            
          end
        end
         end 
      end else if (match_1 == 98) then do
        base = --[[ Bin ]]3;
        i = i + 2 | 0;
      end
       end  end 
    end else if (match_1 ~= 66) then do
      if (match_1 >= 79) then do
        local ___conditional___=(match_1 - 79 | 0);
        do
           if ___conditional___ == 0 then do
              base = --[[ Oct ]]0;
              i = i + 2 | 0; end else 
           if ___conditional___ == 6 then do
              i = i + 2 | 0; end else 
           if ___conditional___ == 1
           or ___conditional___ == 2
           or ___conditional___ == 3
           or ___conditional___ == 4
           or ___conditional___ == 5
           or ___conditional___ == 7
           or ___conditional___ == 8
           or ___conditional___ == 9 then do
              base = --[[ Hex ]]1;
              i = i + 2 | 0; end else 
           end end end end end end
          
        end
      end
       end 
    end else do
      base = --[[ Bin ]]3;
      i = i + 2 | 0;
    end end  end 
  end
   end 
  return --[[ tuple ]]{
          i,
          sign,
          base
        };
end end

function caml_int_of_string(s) do
  match = parse_sign_and_base(s);
  i = match[0];
  base = int_of_string_base(match[2]);
  threshold = 4294967295;
  len = #s;
  c = i < len and s.charCodeAt(i) or --[[ "\000" ]]0;
  d = parse_digit(c);
  if (d < 0 or d >= base) then do
    error({
      Caml_builtin_exceptions.failure,
      "int_of_string"
    })
  end
   end 
  aux = function(_acc, _k) do
    while(true) do
      k = _k;
      acc = _acc;
      if (k == len) then do
        return acc;
      end else do
        a = s.charCodeAt(k);
        if (a == --[[ "_" ]]95) then do
          _k = k + 1 | 0;
          ::continue:: ;
        end else do
          v = parse_digit(a);
          if (v < 0 or v >= base) then do
            error({
              Caml_builtin_exceptions.failure,
              "int_of_string"
            })
          end
           end 
          acc_1 = base * acc + v;
          if (acc_1 > threshold) then do
            error({
              Caml_builtin_exceptions.failure,
              "int_of_string"
            })
          end
           end 
          _k = k + 1 | 0;
          _acc = acc_1;
          ::continue:: ;
        end end 
      end end 
    end;
  end end;
  res = match[1] * aux(d, i + 1 | 0);
  or_res = res | 0;
  if (base == 10 and res ~= or_res) then do
    error({
      Caml_builtin_exceptions.failure,
      "int_of_string"
    })
  end
   end 
  return or_res;
end end

function caml_int64_of_string(s) do
  match = parse_sign_and_base(s);
  hbase = match[2];
  i = match[0];
  base = Caml_int64.of_int32(int_of_string_base(hbase));
  sign = Caml_int64.of_int32(match[1]);
  threshold;
  local ___conditional___=(hbase);
  do
     if ___conditional___ == 0--[[ Oct ]] then do
        threshold = --[[ int64 ]]{
          --[[ hi ]]536870911,
          --[[ lo ]]4294967295
        }; end else 
     if ___conditional___ == 1--[[ Hex ]] then do
        threshold = --[[ int64 ]]{
          --[[ hi ]]268435455,
          --[[ lo ]]4294967295
        }; end else 
     if ___conditional___ == 2--[[ Dec ]] then do
        threshold = --[[ int64 ]]{
          --[[ hi ]]429496729,
          --[[ lo ]]2576980377
        }; end else 
     if ___conditional___ == 3--[[ Bin ]] then do
        threshold = --[[ int64 ]]{
          --[[ hi ]]2147483647,
          --[[ lo ]]4294967295
        }; end else 
     end end end end end end end end
    
  end
  len = #s;
  c = i < len and s.charCodeAt(i) or --[[ "\000" ]]0;
  d = Caml_int64.of_int32(parse_digit(c));
  if (Caml_int64.lt(d, --[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]0
        }) or Caml_int64.ge(d, base)) then do
    error({
      Caml_builtin_exceptions.failure,
      "int64_of_string"
    })
  end
   end 
  aux = function(_acc, _k) do
    while(true) do
      k = _k;
      acc = _acc;
      if (k == len) then do
        return acc;
      end else do
        a = s.charCodeAt(k);
        if (a == --[[ "_" ]]95) then do
          _k = k + 1 | 0;
          ::continue:: ;
        end else do
          v = Caml_int64.of_int32(parse_digit(a));
          if (Caml_int64.lt(v, --[[ int64 ]]{
                  --[[ hi ]]0,
                  --[[ lo ]]0
                }) or Caml_int64.ge(v, base) or Caml_int64.gt(acc, threshold)) then do
            error({
              Caml_builtin_exceptions.failure,
              "int64_of_string"
            })
          end
           end 
          acc_1 = Caml_int64.add(Caml_int64.mul(base, acc), v);
          _k = k + 1 | 0;
          _acc = acc_1;
          ::continue:: ;
        end end 
      end end 
    end;
  end end;
  res = Caml_int64.mul(sign, aux(d, i + 1 | 0));
  or_res = Caml_int64.or_(res, --[[ int64 ]]{
        --[[ hi ]]0,
        --[[ lo ]]0
      });
  if (Caml_int64.eq(base, --[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]10
        }) and Caml_int64.neq(res, or_res)) then do
    error({
      Caml_builtin_exceptions.failure,
      "int64_of_string"
    })
  end
   end 
  return or_res;
end end

function int_of_base(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ == 0--[[ Oct ]] then do
        return 8; end end 
     if ___conditional___ == 1--[[ Hex ]] then do
        return 16; end end 
     if ___conditional___ == 2--[[ Dec ]] then do
        return 10; end end 
    
  end
end end

function lowercase(c) do
  if (c >= --[[ "A" ]]65 and c <= --[[ "Z" ]]90 or c >= --[[ "\192" ]]192 and c <= --[[ "\214" ]]214 or c >= --[[ "\216" ]]216 and c <= --[[ "\222" ]]222) then do
    return c + 32 | 0;
  end else do
    return c;
  end end 
end end

function parse_format(fmt) do
  len = #fmt;
  if (len > 31) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "format_int: format too long"
    })
  end
   end 
  f = {
    justify = "+",
    signstyle = "-",
    filter = " ",
    alternate = false,
    base = --[[ Dec ]]2,
    signedconv = false,
    width = 0,
    uppercase = false,
    sign = 1,
    prec = -1,
    conv = "f"
  };
  _i = 0;
  while(true) do
    i = _i;
    if (i >= len) then do
      return f;
    end else do
      c = fmt.charCodeAt(i);
      exit = 0;
      if (c >= 69) then do
        if (c >= 88) then do
          if (c >= 121) then do
            exit = 1;
          end else do
            local ___conditional___=(c - 88 | 0);
            do
               if ___conditional___ == 0 then do
                  f.base = --[[ Hex ]]1;
                  f.uppercase = true;
                  _i = i + 1 | 0;
                  ::continue:: ; end end 
               if ___conditional___ == 13
               or ___conditional___ == 14
               or ___conditional___ == 15 then do
                  exit = 5; end else 
               if ___conditional___ == 12
               or ___conditional___ == 17 then do
                  exit = 4; end else 
               if ___conditional___ == 23 then do
                  f.base = --[[ Oct ]]0;
                  _i = i + 1 | 0;
                  ::continue:: ; end end end end end end 
               if ___conditional___ == 29 then do
                  f.base = --[[ Dec ]]2;
                  _i = i + 1 | 0;
                  ::continue:: ; end end 
               if ___conditional___ == 1
               or ___conditional___ == 2
               or ___conditional___ == 3
               or ___conditional___ == 4
               or ___conditional___ == 5
               or ___conditional___ == 6
               or ___conditional___ == 7
               or ___conditional___ == 8
               or ___conditional___ == 9
               or ___conditional___ == 10
               or ___conditional___ == 11
               or ___conditional___ == 16
               or ___conditional___ == 18
               or ___conditional___ == 19
               or ___conditional___ == 20
               or ___conditional___ == 21
               or ___conditional___ == 22
               or ___conditional___ == 24
               or ___conditional___ == 25
               or ___conditional___ == 26
               or ___conditional___ == 27
               or ___conditional___ == 28
               or ___conditional___ == 30
               or ___conditional___ == 31 then do
                  exit = 1; end else 
               if ___conditional___ == 32 then do
                  f.base = --[[ Hex ]]1;
                  _i = i + 1 | 0;
                  ::continue:: ; end end end end 
              
            end
          end end 
        end else if (c >= 72) then do
          exit = 1;
        end else do
          f.signedconv = true;
          f.uppercase = true;
          f.conv = String.fromCharCode(lowercase(c));
          _i = i + 1 | 0;
          ::continue:: ;
        end end  end 
      end else do
        local ___conditional___=(c);
        do
           if ___conditional___ == 35 then do
              f.alternate = true;
              _i = i + 1 | 0;
              ::continue:: ; end end 
           if ___conditional___ == 32
           or ___conditional___ == 43 then do
              exit = 2; end else 
           if ___conditional___ == 45 then do
              f.justify = "-";
              _i = i + 1 | 0;
              ::continue:: ; end end end end 
           if ___conditional___ == 46 then do
              f.prec = 0;
              j = i + 1 | 0;
              while((function(j)do
                  return function () do
                    w = fmt.charCodeAt(j) - --[[ "0" ]]48 | 0;
                    return w >= 0 and w <= 9;
                  end end
                  end end)(j)()) do
                f.prec = (Caml_int32.imul(f.prec, 10) + fmt.charCodeAt(j) | 0) - --[[ "0" ]]48 | 0;
                j = j + 1 | 0;
              end;
              _i = j;
              ::continue:: ; end end 
           if ___conditional___ == 33
           or ___conditional___ == 34
           or ___conditional___ == 36
           or ___conditional___ == 37
           or ___conditional___ == 38
           or ___conditional___ == 39
           or ___conditional___ == 40
           or ___conditional___ == 41
           or ___conditional___ == 42
           or ___conditional___ == 44
           or ___conditional___ == 47 then do
              exit = 1; end else 
           if ___conditional___ == 48 then do
              f.filter = "0";
              _i = i + 1 | 0;
              ::continue:: ; end end end end 
           if ___conditional___ == 49
           or ___conditional___ == 50
           or ___conditional___ == 51
           or ___conditional___ == 52
           or ___conditional___ == 53
           or ___conditional___ == 54
           or ___conditional___ == 55
           or ___conditional___ == 56
           or ___conditional___ == 57 then do
              exit = 3; end else 
           end end
          exit = 1;
            
        end
      end end 
      local ___conditional___=(exit);
      do
         if ___conditional___ == 1 then do
            _i = i + 1 | 0;
            ::continue:: ; end end 
         if ___conditional___ == 2 then do
            f.signstyle = String.fromCharCode(c);
            _i = i + 1 | 0;
            ::continue:: ; end end 
         if ___conditional___ == 3 then do
            f.width = 0;
            j_1 = i;
            while((function(j_1)do
                return function () do
                  w = fmt.charCodeAt(j_1) - --[[ "0" ]]48 | 0;
                  return w >= 0 and w <= 9;
                end end
                end end)(j_1)()) do
              f.width = (Caml_int32.imul(f.width, 10) + fmt.charCodeAt(j_1) | 0) - --[[ "0" ]]48 | 0;
              j_1 = j_1 + 1 | 0;
            end;
            _i = j_1;
            ::continue:: ; end end 
         if ___conditional___ == 4 then do
            f.signedconv = true;
            f.base = --[[ Dec ]]2;
            _i = i + 1 | 0;
            ::continue:: ; end end 
         if ___conditional___ == 5 then do
            f.signedconv = true;
            f.conv = String.fromCharCode(c);
            _i = i + 1 | 0;
            ::continue:: ; end end 
        
      end
    end end 
  end;
end end

function finish_formatting(config, rawbuffer) do
  justify = config.justify;
  signstyle = config.signstyle;
  filter = config.filter;
  alternate = config.alternate;
  base = config.base;
  signedconv = config.signedconv;
  width = config.width;
  uppercase = config.uppercase;
  sign = config.sign;
  len = #rawbuffer;
  if (signedconv and (sign < 0 or signstyle ~= "-")) then do
    len = len + 1 | 0;
  end
   end 
  if (alternate) then do
    if (base == --[[ Oct ]]0) then do
      len = len + 1 | 0;
    end else if (base == --[[ Hex ]]1) then do
      len = len + 2 | 0;
    end
     end  end 
  end
   end 
  buffer = "";
  if (justify == "+" and filter == " ") then do
    for _for = len , width - 1 | 0 , 1 do
      buffer = buffer .. filter;
    end
  end
   end 
  if (signedconv) then do
    if (sign < 0) then do
      buffer = buffer .. "-";
    end else if (signstyle ~= "-") then do
      buffer = buffer .. signstyle;
    end
     end  end 
  end
   end 
  if (alternate and base == --[[ Oct ]]0) then do
    buffer = buffer .. "0";
  end
   end 
  if (alternate and base == --[[ Hex ]]1) then do
    buffer = buffer .. "0x";
  end
   end 
  if (justify == "+" and filter == "0") then do
    for _for_1 = len , width - 1 | 0 , 1 do
      buffer = buffer .. filter;
    end
  end
   end 
  buffer = uppercase and buffer .. rawbuffer.toUpperCase() or buffer .. rawbuffer;
  if (justify == "-") then do
    for _for_2 = len , width - 1 | 0 , 1 do
      buffer = buffer .. " ";
    end
  end
   end 
  return buffer;
end end

function caml_format_int(fmt, i) do
  if (fmt == "%d") then do
    return String(i);
  end else do
    f = parse_format(fmt);
    f_1 = f;
    i_1 = i;
    i_2 = i_1 < 0 and (
        f_1.signedconv and (f_1.sign = -1, -i_1) or (i_1 >>> 0)
      ) or i_1;
    s = i_2.toString(int_of_base(f_1.base));
    if (f_1.prec >= 0) then do
      f_1.filter = " ";
      n = f_1.prec - #s | 0;
      if (n > 0) then do
        s = Caml_utils.repeat(n, "0") .. s;
      end
       end 
    end
     end 
    return finish_formatting(f_1, s);
  end end 
end end

function caml_int64_format(fmt, x) do
  f = parse_format(fmt);
  x_1 = f.signedconv and Caml_int64.lt(x, --[[ int64 ]]{
        --[[ hi ]]0,
        --[[ lo ]]0
      }) and (f.sign = -1, Caml_int64.neg(x)) or x;
  s = "";
  match = f.base;
  local ___conditional___=(match);
  do
     if ___conditional___ == 0--[[ Oct ]] then do
        wbase = --[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]8
        };
        cvtbl = "01234567";
        if (Caml_int64.lt(x_1, --[[ int64 ]]{
                --[[ hi ]]0,
                --[[ lo ]]0
              })) then do
          y = Caml_int64.discard_sign(x_1);
          match_1 = Caml_int64.div_mod(y, wbase);
          quotient = Caml_int64.add(--[[ int64 ]]{
                --[[ hi ]]268435456,
                --[[ lo ]]0
              }, match_1[0]);
          modulus = match_1[1];
          s = String.fromCharCode(cvtbl.charCodeAt(Caml_int64.to_int32(modulus))) .. s;
          while(Caml_int64.neq(quotient, --[[ int64 ]]{
                  --[[ hi ]]0,
                  --[[ lo ]]0
                })) do
            match_2 = Caml_int64.div_mod(quotient, wbase);
            quotient = match_2[0];
            modulus = match_2[1];
            s = String.fromCharCode(cvtbl.charCodeAt(Caml_int64.to_int32(modulus))) .. s;
          end;
        end else do
          match_3 = Caml_int64.div_mod(x_1, wbase);
          quotient_1 = match_3[0];
          modulus_1 = match_3[1];
          s = String.fromCharCode(cvtbl.charCodeAt(Caml_int64.to_int32(modulus_1))) .. s;
          while(Caml_int64.neq(quotient_1, --[[ int64 ]]{
                  --[[ hi ]]0,
                  --[[ lo ]]0
                })) do
            match_4 = Caml_int64.div_mod(quotient_1, wbase);
            quotient_1 = match_4[0];
            modulus_1 = match_4[1];
            s = String.fromCharCode(cvtbl.charCodeAt(Caml_int64.to_int32(modulus_1))) .. s;
          end;
        end end  end else 
     if ___conditional___ == 1--[[ Hex ]] then do
        s = Caml_int64.to_hex(x_1) .. s; end else 
     if ___conditional___ == 2--[[ Dec ]] then do
        wbase_1 = --[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]10
        };
        cvtbl_1 = "0123456789";
        if (Caml_int64.lt(x_1, --[[ int64 ]]{
                --[[ hi ]]0,
                --[[ lo ]]0
              })) then do
          y_1 = Caml_int64.discard_sign(x_1);
          match_5 = Caml_int64.div_mod(y_1, wbase_1);
          match_6 = Caml_int64.div_mod(Caml_int64.add(--[[ int64 ]]{
                    --[[ hi ]]0,
                    --[[ lo ]]8
                  }, match_5[1]), wbase_1);
          quotient_2 = Caml_int64.add(Caml_int64.add(--[[ int64 ]]{
                    --[[ hi ]]214748364,
                    --[[ lo ]]3435973836
                  }, match_5[0]), match_6[0]);
          modulus_2 = match_6[1];
          s = String.fromCharCode(cvtbl_1.charCodeAt(Caml_int64.to_int32(modulus_2))) .. s;
          while(Caml_int64.neq(quotient_2, --[[ int64 ]]{
                  --[[ hi ]]0,
                  --[[ lo ]]0
                })) do
            match_7 = Caml_int64.div_mod(quotient_2, wbase_1);
            quotient_2 = match_7[0];
            modulus_2 = match_7[1];
            s = String.fromCharCode(cvtbl_1.charCodeAt(Caml_int64.to_int32(modulus_2))) .. s;
          end;
        end else do
          match_8 = Caml_int64.div_mod(x_1, wbase_1);
          quotient_3 = match_8[0];
          modulus_3 = match_8[1];
          s = String.fromCharCode(cvtbl_1.charCodeAt(Caml_int64.to_int32(modulus_3))) .. s;
          while(Caml_int64.neq(quotient_3, --[[ int64 ]]{
                  --[[ hi ]]0,
                  --[[ lo ]]0
                })) do
            match_9 = Caml_int64.div_mod(quotient_3, wbase_1);
            quotient_3 = match_9[0];
            modulus_3 = match_9[1];
            s = String.fromCharCode(cvtbl_1.charCodeAt(Caml_int64.to_int32(modulus_3))) .. s;
          end;
        end end  end else 
     end end end end end end
    
  end
  if (f.prec >= 0) then do
    f.filter = " ";
    n = f.prec - #s | 0;
    if (n > 0) then do
      s = Caml_utils.repeat(n, "0") .. s;
    end
     end 
  end
   end 
  return finish_formatting(f, s);
end end

function caml_format_float(fmt, x) do
  f = parse_format(fmt);
  prec = f.prec < 0 and 6 or f.prec;
  x_1 = x < 0 and (f.sign = -1, -x) or x;
  s = "";
  if (isNaN(x_1)) then do
    s = "nan";
    f.filter = " ";
  end else if (isFinite(x_1)) then do
    match = f.conv;
    local ___conditional___=(match);
    do
       if ___conditional___ == "e" then do
          s = x_1.toExponential(prec);
          i = #s;
          if (s[i - 3 | 0] == "e") then do
            s = s.slice(0, i - 1 | 0) .. ("0" .. s.slice(i - 1 | 0));
          end
           end  end else 
       if ___conditional___ == "f" then do
          s = x_1.toFixed(prec); end else 
       if ___conditional___ == "g" then do
          prec_1 = prec ~= 0 and prec or 1;
          s = x_1.toExponential(prec_1 - 1 | 0);
          j = s.indexOf("e");
          exp = Number(s.slice(j + 1 | 0)) | 0;
          if (exp < -4 or x_1 >= 1e21 or #x_1.toFixed() > prec_1) then do
            i_1 = j - 1 | 0;
            while(s[i_1] == "0") do
              i_1 = i_1 - 1 | 0;
            end;
            if (s[i_1] == ".") then do
              i_1 = i_1 - 1 | 0;
            end
             end 
            s = s.slice(0, i_1 + 1 | 0) .. s.slice(j);
            i_2 = #s;
            if (s[i_2 - 3 | 0] == "e") then do
              s = s.slice(0, i_2 - 1 | 0) .. ("0" .. s.slice(i_2 - 1 | 0));
            end
             end 
          end else do
            p = prec_1;
            if (exp < 0) then do
              p = p - (exp + 1 | 0) | 0;
              s = x_1.toFixed(p);
            end else do
              while((function() do
                      s = x_1.toFixed(p);
                      return #s > (prec_1 + 1 | 0);
                    end end)()) do
                p = p - 1 | 0;
              end;
            end end 
            if (p ~= 0) then do
              k = #s - 1 | 0;
              while(s[k] == "0") do
                k = k - 1 | 0;
              end;
              if (s[k] == ".") then do
                k = k - 1 | 0;
              end
               end 
              s = s.slice(0, k + 1 | 0);
            end
             end 
          end end  end else 
       end end end end end end
      
    end
  end else do
    s = "inf";
    f.filter = " ";
  end end  end 
  return finish_formatting(f, s);
end end

caml_hexstring_of_float = (function(x,prec,style){
  if (!isFinite(x)) {
    if (isNaN(x)) return "nan";
    return x > 0 ? "infinity":"-infinity";
  }
  var sign = (x==0 && 1/x == -Infinity)?1:(x>=0)?0:1;
  if(sign) x = -x;
  var exp = 0;
  if (x == 0) { }
  else if (x < 1) {
    while (x < 1 && exp > -1022)  { x *= 2; exp-- }
  } else {
    while (x >= 2) { x /= 2; exp++ }
  }
  var exp_sign = exp < 0 ? '' : '+';
  var sign_str = '';
  if (sign) sign_str = '-'
  else {
    switch(style){
    case 43 /* '+' */: sign_str = '+'; break;
    case 32 /* ' ' */: sign_str = ' '; break;
    default: break;
    }
  }
  if (prec >= 0 && prec < 13) {
    /* If a precision is given, and is small, round mantissa accordingly */
      var cst = Math.pow(2,prec * 4);
      x = Math.round(x * cst) / cst;
  }
  var x_str = x.toString(16);
  if(prec >= 0){
      var idx = x_str.indexOf('.');
    if(idx<0) {
      x_str += '.' +  '0'.repeat(prec);
    }
    else {
      var size = idx+1+prec;
      if(x_str.length < size)
        x_str += '0'.repeat(size - x_str.length);
      else
        x_str = x_str.substr(0,size);
    }
  }
  return  (sign_str + '0x' + x_str + 'p' + exp_sign + exp.toString(10));
});

float_of_string = (function(s,exn){

    var res = +s;
    if ((s.length > 0) && (res === res))
        return res;
    s = s.replace(/_/g, "");
    res = +s;
    if (((s.length > 0) && (res === res)) || /^[+-]?nan$/i.test(s)) {
        return res;
    };
    var m = /^ *([+-]?)0x([0-9a-f]+)\.?([0-9a-f]*)p([+-]?[0-9]+)/i.exec(s);
    //            1        2             3           4
    if(m){
        var m3 = m[3].replace(/0+$/,'');
        var mantissa = parseInt(m[1] + m[2] + m3, 16);
        var exponent = (m[4]|0) - 4*m3.length;
        res = mantissa * Math.pow(2, exponent);
        return res;
    }
    if (/^\+?inf(inity)?$/i.test(s))
        return Infinity;
    if (/^-inf(inity)?$/i.test(s))
        return -Infinity;
    throw exn;
});

function caml_float_of_string(s) do
  return float_of_string(s, {
              Caml_builtin_exceptions.failure,
              "float_of_string"
            });
end end

caml_nativeint_format = caml_format_int;

caml_int32_format = caml_format_int;

caml_int32_of_string = caml_int_of_string;

caml_nativeint_of_string = caml_int_of_string;

exports = {}
exports.caml_format_float = caml_format_float;
exports.caml_hexstring_of_float = caml_hexstring_of_float;
exports.caml_format_int = caml_format_int;
exports.caml_nativeint_format = caml_nativeint_format;
exports.caml_int32_format = caml_int32_format;
exports.caml_float_of_string = caml_float_of_string;
exports.caml_int64_format = caml_int64_format;
exports.caml_int_of_string = caml_int_of_string;
exports.caml_int32_of_string = caml_int32_of_string;
exports.caml_int64_of_string = caml_int64_of_string;
exports.caml_nativeint_of_string = caml_nativeint_of_string;
--[[ No side effect ]]
