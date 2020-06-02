--[['use strict';]]

Js_vector = require "./js_vector";
Caml_option = require "./caml_option";

function length(l) do
  _len = 0;
  _param = l;
  while(true) do
    param = _param;
    len = _len;
    if (param) then do
      _param = param[1];
      _len = len + 1 | 0;
      ::continue:: ;
    end else do
      return len;
    end end 
  end;
end end

function cons(x, xs) do
  return --[[ :: ]]{
          x,
          xs
        };
end end

function isEmpty(x) do
  return x == --[[ [] ]]0;
end end

function hd(param) do
  if (param) then do
    return Caml_option.some(param[0]);
  end
   end 
end end

function tl(param) do
  if (param) then do
    return param[1];
  end
   end 
end end

function nth(l, n) do
  if (n < 0) then do
    return ;
  end else do
    _l = l;
    _n = n;
    while(true) do
      n$1 = _n;
      l$1 = _l;
      if (l$1) then do
        if (n$1 == 0) then do
          return Caml_option.some(l$1[0]);
        end else do
          _n = n$1 - 1 | 0;
          _l = l$1[1];
          ::continue:: ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end 
end end

function revAppend(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      _l2 = --[[ :: ]]{
        l1[0],
        l2
      };
      _l1 = l1[1];
      ::continue:: ;
    end else do
      return l2;
    end end 
  end;
end end

function rev(l) do
  return revAppend(l, --[[ [] ]]0);
end end

function mapRevAux(f, _acc, _ls) do
  while(true) do
    ls = _ls;
    acc = _acc;
    if (ls) then do
      _ls = ls[1];
      _acc = --[[ :: ]]{
        f(ls[0]),
        acc
      };
      ::continue:: ;
    end else do
      return acc;
    end end 
  end;
end end

function mapRev(f, ls) do
  return mapRevAux(f, --[[ [] ]]0, ls);
end end

function map(f, ls) do
  return revAppend(mapRevAux(f, --[[ [] ]]0, ls), --[[ [] ]]0);
end end

function iter(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      f(param[0]);
      _param = param[1];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function iteri(f, l) do
  _i = 0;
  f$1 = f;
  _param = l;
  while(true) do
    param = _param;
    i = _i;
    if (param) then do
      f$1(i, param[0]);
      _param = param[1];
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function foldLeft(f, _accu, _l) do
  while(true) do
    l = _l;
    accu = _accu;
    if (l) then do
      _l = l[1];
      _accu = f(accu, l[0]);
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function tailLoop(f, _acc, _param) do
  while(true) do
    param = _param;
    acc = _acc;
    if (param) then do
      _param = param[1];
      _acc = f(param[0], acc);
      ::continue:: ;
    end else do
      return acc;
    end end 
  end;
end end

function foldRight(f, l, init) do
  loop = function (n, param) do
    if (param) then do
      t = param[1];
      h = param[0];
      if (n < 1000) then do
        return f(h, loop(n + 1 | 0, t));
      end else do
        return f(h, tailLoop(f, init, revAppend(t, --[[ [] ]]0)));
      end end 
    end else do
      return init;
    end end 
  end end;
  return loop(0, l);
end end

function flatten(lx) do
  _acc = --[[ [] ]]0;
  _lx = lx;
  while(true) do
    lx$1 = _lx;
    acc = _acc;
    if (lx$1) then do
      _lx = lx$1[1];
      _acc = revAppend(lx$1[0], acc);
      ::continue:: ;
    end else do
      return revAppend(acc, --[[ [] ]]0);
    end end 
  end;
end end

function filterRevAux(f, _acc, _xs) do
  while(true) do
    xs = _xs;
    acc = _acc;
    if (xs) then do
      ys = xs[1];
      y = xs[0];
      if (f(y)) then do
        _xs = ys;
        _acc = --[[ :: ]]{
          y,
          acc
        };
        ::continue:: ;
      end else do
        _xs = ys;
        ::continue:: ;
      end end 
    end else do
      return acc;
    end end 
  end;
end end

function filter(f, xs) do
  return revAppend(filterRevAux(f, --[[ [] ]]0, xs), --[[ [] ]]0);
end end

function filterMapRevAux(f, _acc, _xs) do
  while(true) do
    xs = _xs;
    acc = _acc;
    if (xs) then do
      ys = xs[1];
      match = f(xs[0]);
      _xs = ys;
      if (match ~= undefined) then do
        _acc = --[[ :: ]]{
          Caml_option.valFromOption(match),
          acc
        };
        ::continue:: ;
      end else do
        ::continue:: ;
      end end 
    end else do
      return acc;
    end end 
  end;
end end

function filterMap(f, xs) do
  return revAppend(filterMapRevAux(f, --[[ [] ]]0, xs), --[[ [] ]]0);
end end

function countBy(f, xs) do
  f$1 = f;
  _acc = 0;
  _xs = xs;
  while(true) do
    xs$1 = _xs;
    acc = _acc;
    if (xs$1) then do
      _xs = xs$1[1];
      _acc = f$1(xs$1[0]) and acc + 1 | 0 or acc;
      ::continue:: ;
    end else do
      return acc;
    end end 
  end;
end end

function init(n, f) do
  return Js_vector.toList(Js_vector.init(n, f));
end end

function toVector(xs) do
  if (xs) then do
    a = new Array(length(xs));
    _i = 0;
    _param = xs;
    while(true) do
      param = _param;
      i = _i;
      if (param) then do
        a[i] = param[0];
        _param = param[1];
        _i = i + 1 | 0;
        ::continue:: ;
      end else do
        return a;
      end end 
    end;
  end else do
    return {};
  end end 
end end

function equal(cmp, _xs, _ys) do
  while(true) do
    ys = _ys;
    xs = _xs;
    if (xs) then do
      if (ys and cmp(xs[0], ys[0])) then do
        _ys = ys[1];
        _xs = xs[1];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else if (ys) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

exports.length = length;
exports.cons = cons;
exports.isEmpty = isEmpty;
exports.hd = hd;
exports.tl = tl;
exports.nth = nth;
exports.revAppend = revAppend;
exports.rev = rev;
exports.mapRev = mapRev;
exports.map = map;
exports.iter = iter;
exports.iteri = iteri;
exports.foldLeft = foldLeft;
exports.foldRight = foldRight;
exports.flatten = flatten;
exports.filter = filter;
exports.filterMap = filterMap;
exports.countBy = countBy;
exports.init = init;
exports.toVector = toVector;
exports.equal = equal;
--[[ No side effect ]]
