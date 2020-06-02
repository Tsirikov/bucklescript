--[['use strict';]]

Js_exn = require "../../lib/js/js_exn.lua";
Caml_option = require "../../lib/js/caml_option.lua";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions.lua";

function test_js_error(param) do
  e;
  try do
    e = JSON.parse(" {\"x\" : }");
  end
  catch (raw_exn)do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Js_exn.__Error) then do
      console.log(exn[1].stack);
      return ;
    end else do
      throw exn;
    end end 
  end
  return Caml_option.some(e);
end end

function test_js_error2(param) do
  try do
    return JSON.parse(" {\"x\" : }");
  end
  catch (raw_e)do
    e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e[0] == Js_exn.__Error) then do
      console.log(e[1].stack);
      throw e;
    end else do
      throw e;
    end end 
  end
end end

function example1(param) do
  v;
  try do
    v = JSON.parse(" {\"x\"  }");
  end
  catch (raw_exn)do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Js_exn.__Error) then do
      console.log(exn[1].stack);
      return ;
    end else do
      throw exn;
    end end 
  end
  return Caml_option.some(v);
end end

function example2(param) do
  try do
    return Caml_option.some(JSON.parse(" {\"x\"}"));
  end
  catch (raw_exn)do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Js_exn.__Error) then do
      return ;
    end else do
      throw exn;
    end end 
  end
end end

exports.test_js_error = test_js_error;
exports.test_js_error2 = test_js_error2;
exports.example1 = example1;
exports.example2 = example2;
--[[ No side effect ]]
