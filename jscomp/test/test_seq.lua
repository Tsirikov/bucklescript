--[['use strict';]]

Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Caml_obj = require "../../lib/js/caml_obj";
Pervasives = require "../../lib/js/pervasives";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

Bad = Caml_exceptions.create("Test_seq.Bad");

Help = Caml_exceptions.create("Test_seq.Help");

Stop = Caml_exceptions.create("Test_seq.Stop");

function assoc3(x, _l) do
  while(true) do
    l = _l;
    if (l) then do
      match = l[0];
      if (Caml_obj.caml_equal(match[0], x)) then do
        return match[1];
      end else do
        _l = l[1];
        ::continue:: ;
      end end 
    end else do
      error (Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function help_action(param) do
  error ({
    Stop,
    --[[ Unknown ]]Block.__(0, {"-help"})
  })
end end

function v(speclist) do
  assoc3("-help", speclist);
  return --[[ [] ]]0;
end end

function f(g, speclist) do
  return Curry._1(g, assoc3("-help", speclist));
end end

function add_help(speclist) do
  add1;
  xpcall(function() do
    assoc3("-help", speclist);
    add1 = --[[ [] ]]0;
  end end,function(exn) return do
    if (exn == Caml_builtin_exceptions.not_found) then do
      add1 = --[[ :: ]]{
        --[[ tuple ]]{
          "-help",
          --[[ Unit ]]Block.__(0, {help_action}),
          " Display this list of options"
        },
        --[[ [] ]]0
      };
    end else do
      error (exn)
    end end 
  end end)
  add2;
  xpcall(function() do
    assoc3("--help", speclist);
    add2 = --[[ [] ]]0;
  end end,function(exn$1) return do
    if (exn$1 == Caml_builtin_exceptions.not_found) then do
      add2 = --[[ :: ]]{
        --[[ tuple ]]{
          "--help",
          --[[ Unit ]]Block.__(0, {help_action}),
          " Display this list of options"
        },
        --[[ [] ]]0
      };
    end else do
      error (exn$1)
    end end 
  end end)
  return Pervasives.$at(speclist, Pervasives.$at(add1, add2));
end end

exports.Bad = Bad;
exports.Help = Help;
exports.Stop = Stop;
exports.assoc3 = assoc3;
exports.help_action = help_action;
exports.v = v;
exports.f = f;
exports.add_help = add_help;
--[[ No side effect ]]
