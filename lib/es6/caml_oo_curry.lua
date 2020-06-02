

import * as Curry from "./curry.lua";
import * as Caml_oo from "./caml_oo.lua";

function js(label, cacheid, obj, args) do
  meth = Caml_oo.caml_get_public_method(obj, label, cacheid);
  return Curry.app(meth, args);
end end

function js1(label, cacheid, a0) do
  return Curry._1(Caml_oo.caml_get_public_method(a0, label, cacheid), a0);
end end

function js2(label, cacheid, a0, a1) do
  return Curry._2(Caml_oo.caml_get_public_method(a0, label, cacheid), a0, a1);
end end

function js3(label, cacheid, a0, a1, a2) do
  return Curry._3(Caml_oo.caml_get_public_method(a0, label, cacheid), a0, a1, a2);
end end

function js4(label, cacheid, a0, a1, a2, a3) do
  return Curry._4(Caml_oo.caml_get_public_method(a0, label, cacheid), a0, a1, a2, a3);
end end

function js5(label, cacheid, a0, a1, a2, a3, a4) do
  return Curry._5(Caml_oo.caml_get_public_method(a0, label, cacheid), a0, a1, a2, a3, a4);
end end

function js6(label, cacheid, a0, a1, a2, a3, a4, a5) do
  return Curry._6(Caml_oo.caml_get_public_method(a0, label, cacheid), a0, a1, a2, a3, a4, a5);
end end

function js7(label, cacheid, a0, a1, a2, a3, a4, a5, a6) do
  return Curry._7(Caml_oo.caml_get_public_method(a0, label, cacheid), a0, a1, a2, a3, a4, a5, a6);
end end

function js8(label, cacheid, a0, a1, a2, a3, a4, a5, a6, a7) do
  return Curry._8(Caml_oo.caml_get_public_method(a0, label, cacheid), a0, a1, a2, a3, a4, a5, a6, a7);
end end

export do
  js ,
  js1 ,
  js2 ,
  js3 ,
  js4 ,
  js5 ,
  js6 ,
  js7 ,
  js8 ,
  
end
--[[ No side effect ]]