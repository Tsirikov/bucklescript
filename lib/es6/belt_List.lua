

import * as Curry from "./curry.lua";
import * as Belt_Array from "./belt_Array.lua";
import * as Caml_option from "./caml_option.lua";
import * as Belt_SortArray from "./belt_SortArray.lua";

function head(x) do
  if (x) then do
    return Caml_option.some(x[0]);
  end
   end 
end end

function headExn(x) do
  if (x) then do
    return x[0];
  end else do
    throw new Error("headExn");
  end end 
end end

function tail(x) do
  if (x) then do
    return x[1];
  end
   end 
end end

function tailExn(x) do
  if (x) then do
    return x[1];
  end else do
    throw new Error("tailExn");
  end end 
end end

function add(xs, x) do
  return --[[ :: ]][
          x,
          xs
        ];
end end

function get(x, n) do
  if (n < 0) then do
    return ;
  end else do
    _x = x;
    _n = n;
    while(true) do
      n$1 = _n;
      x$1 = _x;
      if (x$1) then do
        if (n$1 == 0) then do
          return Caml_option.some(x$1[0]);
        end else do
          _n = n$1 - 1 | 0;
          _x = x$1[1];
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end 
end end

function getExn(x, n) do
  if (n < 0) then do
    throw new Error("getExn");
  end
   end 
  _x = x;
  _n = n;
  while(true) do
    n$1 = _n;
    x$1 = _x;
    if (x$1) then do
      if (n$1 == 0) then do
        return x$1[0];
      end else do
        _n = n$1 - 1 | 0;
        _x = x$1[1];
        continue ;
      end end 
    end else do
      throw new Error("getExn");
    end end 
  end;
end end

function partitionAux(p, _cell, _precX, _precY) do
  while(true) do
    precY = _precY;
    precX = _precX;
    cell = _cell;
    if (cell) then do
      t = cell[1];
      h = cell[0];
      next = --[[ :: ]][
        h,
        --[[ [] ]]0
      ];
      if (p(h)) then do
        precX[1] = next;
        _precX = next;
        _cell = t;
        continue ;
      end else do
        precY[1] = next;
        _precY = next;
        _cell = t;
        continue ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function splitAux(_cell, _precX, _precY) do
  while(true) do
    precY = _precY;
    precX = _precX;
    cell = _cell;
    if (cell) then do
      match = cell[0];
      nextA = --[[ :: ]][
        match[0],
        --[[ [] ]]0
      ];
      nextB = --[[ :: ]][
        match[1],
        --[[ [] ]]0
      ];
      precX[1] = nextA;
      precY[1] = nextB;
      _precY = nextB;
      _precX = nextA;
      _cell = cell[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxCont(_cellX, _prec) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      next = --[[ :: ]][
        cellX[0],
        --[[ [] ]]0
      ];
      prec[1] = next;
      _prec = next;
      _cellX = cellX[1];
      continue ;
    end else do
      return prec;
    end end 
  end;
end end

function copyAuxWitFilter(f, _cellX, _prec) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[1];
      h = cellX[0];
      if (f(h)) then do
        next = --[[ :: ]][
          h,
          --[[ [] ]]0
        ];
        prec[1] = next;
        _prec = next;
        _cellX = t;
        continue ;
      end else do
        _cellX = t;
        continue ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxWithFilterIndex(f, _cellX, _prec, _i) do
  while(true) do
    i = _i;
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[1];
      h = cellX[0];
      if (f(h, i)) then do
        next = --[[ :: ]][
          h,
          --[[ [] ]]0
        ];
        prec[1] = next;
        _i = i + 1 | 0;
        _prec = next;
        _cellX = t;
        continue ;
      end else do
        _i = i + 1 | 0;
        _cellX = t;
        continue ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxWitFilterMap(f, _cellX, _prec) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[1];
      match = f(cellX[0]);
      if (match ~= undefined) then do
        next = --[[ :: ]][
          Caml_option.valFromOption(match),
          --[[ [] ]]0
        ];
        prec[1] = next;
        _prec = next;
        _cellX = t;
        continue ;
      end else do
        _cellX = t;
        continue ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function removeAssocAuxWithMap(_cellX, x, _prec, f) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[1];
      h = cellX[0];
      if (f(h[0], x)) then do
        prec[1] = t;
        return true;
      end else do
        next = --[[ :: ]][
          h,
          --[[ [] ]]0
        ];
        prec[1] = next;
        _prec = next;
        _cellX = t;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function setAssocAuxWithMap(_cellX, x, k, _prec, eq) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[1];
      h = cellX[0];
      if (eq(h[0], x)) then do
        prec[1] = --[[ :: ]][
          --[[ tuple ]][
            x,
            k
          ],
          t
        ];
        return true;
      end else do
        next = --[[ :: ]][
          h,
          --[[ [] ]]0
        ];
        prec[1] = next;
        _prec = next;
        _cellX = t;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function copyAuxWithMap(_cellX, _prec, f) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      next = --[[ :: ]][
        f(cellX[0]),
        --[[ [] ]]0
      ];
      prec[1] = next;
      _prec = next;
      _cellX = cellX[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function zipAux(_cellX, _cellY, _prec) do
  while(true) do
    prec = _prec;
    cellY = _cellY;
    cellX = _cellX;
    if (cellX and cellY) then do
      next = --[[ :: ]][
        --[[ tuple ]][
          cellX[0],
          cellY[0]
        ],
        --[[ [] ]]0
      ];
      prec[1] = next;
      _prec = next;
      _cellY = cellY[1];
      _cellX = cellX[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxWithMap2(f, _cellX, _cellY, _prec) do
  while(true) do
    prec = _prec;
    cellY = _cellY;
    cellX = _cellX;
    if (cellX and cellY) then do
      next = --[[ :: ]][
        f(cellX[0], cellY[0]),
        --[[ [] ]]0
      ];
      prec[1] = next;
      _prec = next;
      _cellY = cellY[1];
      _cellX = cellX[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxWithMapI(f, _i, _cellX, _prec) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    i = _i;
    if (cellX) then do
      next = --[[ :: ]][
        f(i, cellX[0]),
        --[[ [] ]]0
      ];
      prec[1] = next;
      _prec = next;
      _cellX = cellX[1];
      _i = i + 1 | 0;
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function takeAux(_n, _cell, _prec) do
  while(true) do
    prec = _prec;
    cell = _cell;
    n = _n;
    if (n == 0) then do
      return true;
    end else if (cell) then do
      cell$1 = --[[ :: ]][
        cell[0],
        --[[ [] ]]0
      ];
      prec[1] = cell$1;
      _prec = cell$1;
      _cell = cell[1];
      _n = n - 1 | 0;
      continue ;
    end else do
      return false;
    end end  end 
  end;
end end

function splitAtAux(_n, _cell, _prec) do
  while(true) do
    prec = _prec;
    cell = _cell;
    n = _n;
    if (n == 0) then do
      return cell;
    end else if (cell) then do
      cell$1 = --[[ :: ]][
        cell[0],
        --[[ [] ]]0
      ];
      prec[1] = cell$1;
      _prec = cell$1;
      _cell = cell[1];
      _n = n - 1 | 0;
      continue ;
    end else do
      return ;
    end end  end 
  end;
end end

function take(lst, n) do
  if (n < 0) then do
    return ;
  end else if (n == 0) then do
    return --[[ [] ]]0;
  end else if (lst) then do
    cell = --[[ :: ]][
      lst[0],
      --[[ [] ]]0
    ];
    has = takeAux(n - 1 | 0, lst[1], cell);
    if (has) then do
      return cell;
    end else do
      return ;
    end end 
  end else do
    return ;
  end end  end  end 
end end

function drop(lst, n) do
  if (n < 0) then do
    return ;
  end else do
    _l = lst;
    _n = n;
    while(true) do
      n$1 = _n;
      l = _l;
      if (n$1 == 0) then do
        return l;
      end else if (l) then do
        _n = n$1 - 1 | 0;
        _l = l[1];
        continue ;
      end else do
        return ;
      end end  end 
    end;
  end end 
end end

function splitAt(lst, n) do
  if (n < 0) then do
    return ;
  end else if (n == 0) then do
    return --[[ tuple ]][
            --[[ [] ]]0,
            lst
          ];
  end else if (lst) then do
    cell = --[[ :: ]][
      lst[0],
      --[[ [] ]]0
    ];
    rest = splitAtAux(n - 1 | 0, lst[1], cell);
    if (rest ~= undefined) then do
      return --[[ tuple ]][
              cell,
              rest
            ];
    end else do
      return ;
    end end 
  end else do
    return ;
  end end  end  end 
end end

function concat(xs, ys) do
  if (xs) then do
    cell = --[[ :: ]][
      xs[0],
      --[[ [] ]]0
    ];
    copyAuxCont(xs[1], cell)[1] = ys;
    return cell;
  end else do
    return ys;
  end end 
end end

function mapU(xs, f) do
  if (xs) then do
    cell = --[[ :: ]][
      f(xs[0]),
      --[[ [] ]]0
    ];
    copyAuxWithMap(xs[1], cell, f);
    return cell;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function map(xs, f) do
  return mapU(xs, Curry.__1(f));
end end

function zipByU(l1, l2, f) do
  if (l1 and l2) then do
    cell = --[[ :: ]][
      f(l1[0], l2[0]),
      --[[ [] ]]0
    ];
    copyAuxWithMap2(f, l1[1], l2[1], cell);
    return cell;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function zipBy(l1, l2, f) do
  return zipByU(l1, l2, Curry.__2(f));
end end

function mapWithIndexU(xs, f) do
  if (xs) then do
    cell = --[[ :: ]][
      f(0, xs[0]),
      --[[ [] ]]0
    ];
    copyAuxWithMapI(f, 1, xs[1], cell);
    return cell;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function mapWithIndex(xs, f) do
  return mapWithIndexU(xs, Curry.__2(f));
end end

function makeByU(n, f) do
  if (n <= 0) then do
    return --[[ [] ]]0;
  end else do
    headX = --[[ :: ]][
      f(0),
      --[[ [] ]]0
    ];
    cur = headX;
    i = 1;
    while(i < n) do
      v = --[[ :: ]][
        f(i),
        --[[ [] ]]0
      ];
      cur[1] = v;
      cur = v;
      i = i + 1 | 0;
    end;
    return headX;
  end end 
end end

function makeBy(n, f) do
  return makeByU(n, Curry.__1(f));
end end

function make(n, v) do
  if (n <= 0) then do
    return --[[ [] ]]0;
  end else do
    headX = --[[ :: ]][
      v,
      --[[ [] ]]0
    ];
    cur = headX;
    i = 1;
    while(i < n) do
      v$1 = --[[ :: ]][
        v,
        --[[ [] ]]0
      ];
      cur[1] = v$1;
      cur = v$1;
      i = i + 1 | 0;
    end;
    return headX;
  end end 
end end

function length(xs) do
  _x = xs;
  _acc = 0;
  while(true) do
    acc = _acc;
    x = _x;
    if (x) then do
      _acc = acc + 1 | 0;
      _x = x[1];
      continue ;
    end else do
      return acc;
    end end 
  end;
end end

function fillAux(arr, _i, _x) do
  while(true) do
    x = _x;
    i = _i;
    if (x) then do
      arr[i] = x[0];
      _x = x[1];
      _i = i + 1 | 0;
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function fromArray(a) do
  a$1 = a;
  _i = #a - 1 | 0;
  _res = --[[ [] ]]0;
  while(true) do
    res = _res;
    i = _i;
    if (i < 0) then do
      return res;
    end else do
      _res = --[[ :: ]][
        a$1[i],
        res
      ];
      _i = i - 1 | 0;
      continue ;
    end end 
  end;
end end

function toArray(x) do
  len = length(x);
  arr = new Array(len);
  fillAux(arr, 0, x);
  return arr;
end end

function shuffle(xs) do
  v = toArray(xs);
  Belt_Array.shuffleInPlace(v);
  return fromArray(v);
end end

function reverseConcat(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      _l2 = --[[ :: ]][
        l1[0],
        l2
      ];
      _l1 = l1[1];
      continue ;
    end else do
      return l2;
    end end 
  end;
end end

function reverse(l) do
  return reverseConcat(l, --[[ [] ]]0);
end end

function flattenAux(_prec, _xs) do
  while(true) do
    xs = _xs;
    prec = _prec;
    if (xs) then do
      _xs = xs[1];
      _prec = copyAuxCont(xs[0], prec);
      continue ;
    end else do
      prec[1] = --[[ [] ]]0;
      return --[[ () ]]0;
    end end 
  end;
end end

function flatten(_xs) do
  while(true) do
    xs = _xs;
    if (xs) then do
      match = xs[0];
      if (match) then do
        cell = --[[ :: ]][
          match[0],
          --[[ [] ]]0
        ];
        flattenAux(copyAuxCont(match[1], cell), xs[1]);
        return cell;
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function concatMany(xs) do
  len = #xs;
  if (len ~= 1) then do
    if (len ~= 0) then do
      len$1 = #xs;
      v = xs[len$1 - 1 | 0];
      for i = len$1 - 2 | 0 , 0 , -1 do
        v = concat(xs[i], v);
      end
      return v;
    end else do
      return --[[ [] ]]0;
    end end 
  end else do
    return xs[0];
  end end 
end end

function mapReverseU(l, f) do
  f$1 = f;
  _accu = --[[ [] ]]0;
  _xs = l;
  while(true) do
    xs = _xs;
    accu = _accu;
    if (xs) then do
      _xs = xs[1];
      _accu = --[[ :: ]][
        f$1(xs[0]),
        accu
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function mapReverse(l, f) do
  return mapReverseU(l, Curry.__1(f));
end end

function forEachU(_xs, f) do
  while(true) do
    xs = _xs;
    if (xs) then do
      f(xs[0]);
      _xs = xs[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEach(xs, f) do
  return forEachU(xs, Curry.__1(f));
end end

function forEachWithIndexU(l, f) do
  _xs = l;
  _i = 0;
  f$1 = f;
  while(true) do
    i = _i;
    xs = _xs;
    if (xs) then do
      f$1(i, xs[0]);
      _i = i + 1 | 0;
      _xs = xs[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEachWithIndex(l, f) do
  return forEachWithIndexU(l, Curry.__2(f));
end end

function reduceU(_l, _accu, f) do
  while(true) do
    accu = _accu;
    l = _l;
    if (l) then do
      _accu = f(accu, l[0]);
      _l = l[1];
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function reduce(l, accu, f) do
  return reduceU(l, accu, Curry.__2(f));
end end

function reduceReverseUnsafeU(l, accu, f) do
  if (l) then do
    return f(reduceReverseUnsafeU(l[1], accu, f), l[0]);
  end else do
    return accu;
  end end 
end end

function reduceReverseU(l, acc, f) do
  len = length(l);
  if (len < 1000) then do
    return reduceReverseUnsafeU(l, acc, f);
  end else do
    return Belt_Array.reduceReverseU(toArray(l), acc, f);
  end end 
end end

function reduceReverse(l, accu, f) do
  return reduceReverseU(l, accu, Curry.__2(f));
end end

function reduceWithIndexU(l, acc, f) do
  _l = l;
  _acc = acc;
  f$1 = f;
  _i = 0;
  while(true) do
    i = _i;
    acc$1 = _acc;
    l$1 = _l;
    if (l$1) then do
      _i = i + 1 | 0;
      _acc = f$1(acc$1, l$1[0], i);
      _l = l$1[1];
      continue ;
    end else do
      return acc$1;
    end end 
  end;
end end

function reduceWithIndex(l, acc, f) do
  return reduceWithIndexU(l, acc, Curry.__3(f));
end end

function mapReverse2U(l1, l2, f) do
  _l1 = l1;
  _l2 = l2;
  _accu = --[[ [] ]]0;
  f$1 = f;
  while(true) do
    accu = _accu;
    l2$1 = _l2;
    l1$1 = _l1;
    if (l1$1 and l2$1) then do
      _accu = --[[ :: ]][
        f$1(l1$1[0], l2$1[0]),
        accu
      ];
      _l2 = l2$1[1];
      _l1 = l1$1[1];
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function mapReverse2(l1, l2, f) do
  return mapReverse2U(l1, l2, Curry.__2(f));
end end

function forEach2U(_l1, _l2, f) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1 and l2) then do
      f(l1[0], l2[0]);
      _l2 = l2[1];
      _l1 = l1[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEach2(l1, l2, f) do
  return forEach2U(l1, l2, Curry.__2(f));
end end

function reduce2U(_l1, _l2, _accu, f) do
  while(true) do
    accu = _accu;
    l2 = _l2;
    l1 = _l1;
    if (l1 and l2) then do
      _accu = f(accu, l1[0], l2[0]);
      _l2 = l2[1];
      _l1 = l1[1];
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function reduce2(l1, l2, acc, f) do
  return reduce2U(l1, l2, acc, Curry.__3(f));
end end

function reduceReverse2UnsafeU(l1, l2, accu, f) do
  if (l1 and l2) then do
    return f(reduceReverse2UnsafeU(l1[1], l2[1], accu, f), l1[0], l2[0]);
  end else do
    return accu;
  end end 
end end

function reduceReverse2U(l1, l2, acc, f) do
  len = length(l1);
  if (len < 1000) then do
    return reduceReverse2UnsafeU(l1, l2, acc, f);
  end else do
    return Belt_Array.reduceReverse2U(toArray(l1), toArray(l2), acc, f);
  end end 
end end

function reduceReverse2(l1, l2, acc, f) do
  return reduceReverse2U(l1, l2, acc, Curry.__3(f));
end end

function everyU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      if (p(xs[0])) then do
        _xs = xs[1];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function every(xs, p) do
  return everyU(xs, Curry.__1(p));
end end

function someU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      if (p(xs[0])) then do
        return true;
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function some(xs, p) do
  return someU(xs, Curry.__1(p));
end end

function every2U(_l1, _l2, p) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1 and l2) then do
      if (p(l1[0], l2[0])) then do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function every2(l1, l2, p) do
  return every2U(l1, l2, Curry.__2(p));
end end

function cmpByLength(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return 1;
      end end 
    end else if (l2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end end

function cmpU(_l1, _l2, p) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        c = p(l1[0], l2[0]);
        if (c == 0) then do
          _l2 = l2[1];
          _l1 = l1[1];
          continue ;
        end else do
          return c;
        end end 
      end else do
        return 1;
      end end 
    end else if (l2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end end

function cmp(l1, l2, f) do
  return cmpU(l1, l2, Curry.__2(f));
end end

function eqU(_l1, _l2, p) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2 and p(l1[0], l2[0])) then do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return false;
      end end 
    end else if (l2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

function eq(l1, l2, f) do
  return eqU(l1, l2, Curry.__2(f));
end end

function some2U(_l1, _l2, p) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1 and l2) then do
      if (p(l1[0], l2[0])) then do
        return true;
      end else do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function some2(l1, l2, p) do
  return some2U(l1, l2, Curry.__2(p));
end end

function hasU(_xs, x, eq) do
  while(true) do
    xs = _xs;
    if (xs) then do
      if (eq(xs[0], x)) then do
        return true;
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function has(xs, x, eq) do
  return hasU(xs, x, Curry.__2(eq));
end end

function getAssocU(_xs, x, eq) do
  while(true) do
    xs = _xs;
    if (xs) then do
      match = xs[0];
      if (eq(match[0], x)) then do
        return Caml_option.some(match[1]);
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getAssoc(xs, x, eq) do
  return getAssocU(xs, x, Curry.__2(eq));
end end

function hasAssocU(_xs, x, eq) do
  while(true) do
    xs = _xs;
    if (xs) then do
      if (eq(xs[0][0], x)) then do
        return true;
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function hasAssoc(xs, x, eq) do
  return hasAssocU(xs, x, Curry.__2(eq));
end end

function removeAssocU(xs, x, eq) do
  if (xs) then do
    l = xs[1];
    pair = xs[0];
    if (eq(pair[0], x)) then do
      return l;
    end else do
      cell = --[[ :: ]][
        pair,
        --[[ [] ]]0
      ];
      removed = removeAssocAuxWithMap(l, x, cell, eq);
      if (removed) then do
        return cell;
      end else do
        return xs;
      end end 
    end end 
  end else do
    return --[[ [] ]]0;
  end end 
end end

function removeAssoc(xs, x, eq) do
  return removeAssocU(xs, x, Curry.__2(eq));
end end

function setAssocU(xs, x, k, eq) do
  if (xs) then do
    l = xs[1];
    pair = xs[0];
    if (eq(pair[0], x)) then do
      return --[[ :: ]][
              --[[ tuple ]][
                x,
                k
              ],
              l
            ];
    end else do
      cell = --[[ :: ]][
        pair,
        --[[ [] ]]0
      ];
      replaced = setAssocAuxWithMap(l, x, k, cell, eq);
      if (replaced) then do
        return cell;
      end else do
        return --[[ :: ]][
                --[[ tuple ]][
                  x,
                  k
                ],
                xs
              ];
      end end 
    end end 
  end else do
    return --[[ :: ]][
            --[[ tuple ]][
              x,
              k
            ],
            --[[ [] ]]0
          ];
  end end 
end end

function setAssoc(xs, x, k, eq) do
  return setAssocU(xs, x, k, Curry.__2(eq));
end end

function sortU(xs, cmp) do
  arr = toArray(xs);
  Belt_SortArray.stableSortInPlaceByU(arr, cmp);
  return fromArray(arr);
end end

function sort(xs, cmp) do
  return sortU(xs, Curry.__2(cmp));
end end

function getByU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      x = xs[0];
      if (p(x)) then do
        return Caml_option.some(x);
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getBy(xs, p) do
  return getByU(xs, Curry.__1(p));
end end

function keepU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      t = xs[1];
      h = xs[0];
      if (p(h)) then do
        cell = --[[ :: ]][
          h,
          --[[ [] ]]0
        ];
        copyAuxWitFilter(p, t, cell);
        return cell;
      end else do
        _xs = t;
        continue ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function keep(xs, p) do
  return keepU(xs, Curry.__1(p));
end end

function keepWithIndexU(xs, p) do
  _xs = xs;
  p$1 = p;
  _i = 0;
  while(true) do
    i = _i;
    xs$1 = _xs;
    if (xs$1) then do
      t = xs$1[1];
      h = xs$1[0];
      if (p$1(h, i)) then do
        cell = --[[ :: ]][
          h,
          --[[ [] ]]0
        ];
        copyAuxWithFilterIndex(p$1, t, cell, i + 1 | 0);
        return cell;
      end else do
        _i = i + 1 | 0;
        _xs = t;
        continue ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function keepWithIndex(xs, p) do
  return keepWithIndexU(xs, Curry.__2(p));
end end

function keepMapU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      t = xs[1];
      match = p(xs[0]);
      if (match ~= undefined) then do
        cell = --[[ :: ]][
          Caml_option.valFromOption(match),
          --[[ [] ]]0
        ];
        copyAuxWitFilterMap(p, t, cell);
        return cell;
      end else do
        _xs = t;
        continue ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function keepMap(xs, p) do
  return keepMapU(xs, Curry.__1(p));
end end

function partitionU(l, p) do
  if (l) then do
    h = l[0];
    nextX = --[[ :: ]][
      h,
      --[[ [] ]]0
    ];
    nextY = --[[ :: ]][
      h,
      --[[ [] ]]0
    ];
    b = p(h);
    partitionAux(p, l[1], nextX, nextY);
    if (b) then do
      return --[[ tuple ]][
              nextX,
              nextY[1]
            ];
    end else do
      return --[[ tuple ]][
              nextX[1],
              nextY
            ];
    end end 
  end else do
    return --[[ tuple ]][
            --[[ [] ]]0,
            --[[ [] ]]0
          ];
  end end 
end end

function partition(l, p) do
  return partitionU(l, Curry.__1(p));
end end

function unzip(xs) do
  if (xs) then do
    match = xs[0];
    cellX = --[[ :: ]][
      match[0],
      --[[ [] ]]0
    ];
    cellY = --[[ :: ]][
      match[1],
      --[[ [] ]]0
    ];
    splitAux(xs[1], cellX, cellY);
    return --[[ tuple ]][
            cellX,
            cellY
          ];
  end else do
    return --[[ tuple ]][
            --[[ [] ]]0,
            --[[ [] ]]0
          ];
  end end 
end end

function zip(l1, l2) do
  if (l1 and l2) then do
    cell = --[[ :: ]][
      --[[ tuple ]][
        l1[0],
        l2[0]
      ],
      --[[ [] ]]0
    ];
    zipAux(l1[1], l2[1], cell);
    return cell;
  end else do
    return --[[ [] ]]0;
  end end 
end end

size = length;

filter = keep;

filterWithIndex = keepWithIndex;

export do
  length ,
  size ,
  head ,
  headExn ,
  tail ,
  tailExn ,
  add ,
  get ,
  getExn ,
  make ,
  makeByU ,
  makeBy ,
  shuffle ,
  drop ,
  take ,
  splitAt ,
  concat ,
  concatMany ,
  reverseConcat ,
  flatten ,
  mapU ,
  map ,
  zip ,
  zipByU ,
  zipBy ,
  mapWithIndexU ,
  mapWithIndex ,
  fromArray ,
  toArray ,
  reverse ,
  mapReverseU ,
  mapReverse ,
  forEachU ,
  forEach ,
  forEachWithIndexU ,
  forEachWithIndex ,
  reduceU ,
  reduce ,
  reduceWithIndexU ,
  reduceWithIndex ,
  reduceReverseU ,
  reduceReverse ,
  mapReverse2U ,
  mapReverse2 ,
  forEach2U ,
  forEach2 ,
  reduce2U ,
  reduce2 ,
  reduceReverse2U ,
  reduceReverse2 ,
  everyU ,
  every ,
  someU ,
  some ,
  every2U ,
  every2 ,
  some2U ,
  some2 ,
  cmpByLength ,
  cmpU ,
  cmp ,
  eqU ,
  eq ,
  hasU ,
  has ,
  getByU ,
  getBy ,
  keepU ,
  keep ,
  filter ,
  keepWithIndexU ,
  keepWithIndex ,
  filterWithIndex ,
  keepMapU ,
  keepMap ,
  partitionU ,
  partition ,
  unzip ,
  getAssocU ,
  getAssoc ,
  hasAssocU ,
  hasAssoc ,
  removeAssocU ,
  removeAssoc ,
  setAssocU ,
  setAssoc ,
  sortU ,
  sort ,
  
end
--[[ No side effect ]]