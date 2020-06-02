--[['use strict';]]

Curry = require "../../lib/js/curry";
Hashtbl = require "../../lib/js/hashtbl";
Caml_primitive = require "../../lib/js/caml_primitive";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function Make(funarg) do
  __let = funarg.V;
  H = Hashtbl.Make(do
        equal: __let.equal,
        hash: __let.hash
      end);
  find_default = function (htbl, x) do
    xpcall(function() do
      return Curry._2(H.find, htbl, x);
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.not_found) then do
        return false;
      end else do
        error(exn)
      end end 
    end end)
  end end;
  min_cutset = function (gr, first_node) do
    n_labels = Curry._1(H.create, 97);
    l_labels = Curry._1(H.create, 97);
    already_processed = Curry._1(H.create, 97);
    on_the_stack = Curry._1(H.create, 97);
    cut_set = do
      contents: --[[ [] ]]0
    end;
    counter = do
      contents: 1
    end;
    step2 = function (top, rest_of_stack) do
      if (find_default(already_processed, top)) then do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "gpr_405_test.ml",
            43,
            6
          }
        })
      end
       end 
      if (find_default(on_the_stack, top)) then do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "gpr_405_test.ml",
            44,
            6
          }
        })
      end
       end 
      Curry._3(H.add, on_the_stack, top, true);
      Curry._3(H.add, n_labels, top, counter.contents);
      counter.contents = counter.contents + 1 | 0;
      Curry._3(H.add, l_labels, top, 0);
      Curry._3(H.add, already_processed, top, true);
      _successors = Curry._2(funarg.succ, gr, top);
      _top = top;
      _rest_of_stack = rest_of_stack;
      while(true) do
        rest_of_stack_1 = _rest_of_stack;
        top_1 = _top;
        successors = _successors;
        if (successors) then do
          successor = successors[0];
          if (find_default(already_processed, successor)) then do
            x = find_default(on_the_stack, successor) and Curry._2(H.find, n_labels, successor) or Curry._2(H.find, l_labels, successor);
            Curry._3(H.add, l_labels, top_1, Caml_primitive.caml_int_max(Curry._2(H.find, l_labels, top_1), x));
            _successors = successors[1];
            ::continue:: ;
          end else do
            return step2(successor, --[[ :: ]]{
                        --[[ tuple ]]{
                          top_1,
                          successors
                        },
                        rest_of_stack_1
                      });
          end end 
        end else do
          if (Curry._2(H.find, l_labels, top_1) == Curry._2(H.find, n_labels, top_1)) then do
            cut_set.contents = --[[ :: ]]{
              top_1,
              cut_set.contents
            };
            Curry._3(H.add, l_labels, top_1, 0);
          end
           end 
          if (Curry._2(H.find, l_labels, top_1) > Curry._2(H.find, n_labels, top_1)) then do
            error({
              Caml_builtin_exceptions.invalid_argument,
              "Graph.Mincut: graph not reducible"
            })
          end
           end 
          if (rest_of_stack_1) then do
            match = rest_of_stack_1[0];
            new_top = match[0];
            Curry._3(H.add, on_the_stack, top_1, false);
            Curry._3(H.add, l_labels, new_top, Caml_primitive.caml_int_max(Curry._2(H.find, l_labels, top_1), Curry._2(H.find, l_labels, new_top)));
            _rest_of_stack = rest_of_stack_1[1];
            _top = new_top;
            _successors = match[1];
            ::continue:: ;
          end else do
            return cut_set.contents;
          end end 
        end end 
      end;
    end end;
    return step2(first_node, --[[ [] ]]0);
  end end;
  return do
          min_cutset: min_cutset
        end;
end end

exports.Make = Make;
--[[ No side effect ]]
