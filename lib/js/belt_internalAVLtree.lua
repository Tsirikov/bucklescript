--[['use strict';]]

Curry = require "./curry.lua";
Caml_option = require "./caml_option.lua";
Belt_SortArray = require "./belt_SortArray.lua";

function treeHeight(n) do
  if (n ~= null) then do
    return n.height;
  end else do
    return 0;
  end end 
end end

function copy(n) do
  if (n ~= null) then do
    l = n.left;
    r = n.right;
    return do
            key: n.key,
            value: n.value,
            height: n.height,
            left: copy(l),
            right: copy(r)
          end;
  end else do
    return n;
  end end 
end end

function create(l, x, d, r) do
  hl = treeHeight(l);
  hr = treeHeight(r);
  return do
          key: x,
          value: d,
          height: hl >= hr and hl + 1 | 0 or hr + 1 | 0,
          left: l,
          right: r
        end;
end end

function singleton(x, d) do
  return do
          key: x,
          value: d,
          height: 1,
          left: null,
          right: null
        end;
end end

function heightGe(l, r) do
  if (r ~= null) then do
    if (l ~= null) then do
      return l.height >= r.height;
    end else do
      return false;
    end end 
  end else do
    return true;
  end end 
end end

function updateValue(n, newValue) do
  if (n.value == newValue) then do
    return n;
  end else do
    return do
            key: n.key,
            value: newValue,
            height: n.height,
            left: n.left,
            right: n.right
          end;
  end end 
end end

function bal(l, x, d, r) do
  hl = l ~= null and l.height or 0;
  hr = r ~= null and r.height or 0;
  if (hl > (hr + 2 | 0)) then do
    ll = l.left;
    lv = l.key;
    ld = l.value;
    lr = l.right;
    if (treeHeight(ll) >= treeHeight(lr)) then do
      return create(ll, lv, ld, create(lr, x, d, r));
    end else do
      lrl = lr.left;
      lrv = lr.key;
      lrd = lr.value;
      lrr = lr.right;
      return create(create(ll, lv, ld, lrl), lrv, lrd, create(lrr, x, d, r));
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    rl = r.left;
    rv = r.key;
    rd = r.value;
    rr = r.right;
    if (treeHeight(rr) >= treeHeight(rl)) then do
      return create(create(l, x, d, rl), rv, rd, rr);
    end else do
      rll = rl.left;
      rlv = rl.key;
      rld = rl.value;
      rlr = rl.right;
      return create(create(l, x, d, rll), rlv, rld, create(rlr, rv, rd, rr));
    end end 
  end else do
    return do
            key: x,
            value: d,
            height: hl >= hr and hl + 1 | 0 or hr + 1 | 0,
            left: l,
            right: r
          end;
  end end  end 
end end

function minKey0Aux(_n) do
  while(true) do
    n = _n;
    match = n.left;
    if (match ~= null) then do
      _n = match;
      continue ;
    end else do
      return n.key;
    end end 
  end;
end end

function minKey(n) do
  if (n ~= null) then do
    return Caml_option.some(minKey0Aux(n));
  end
   end 
end end

function minKeyUndefined(n) do
  if (n ~= null) then do
    return minKey0Aux(n);
  end
   end 
end end

function maxKey0Aux(_n) do
  while(true) do
    n = _n;
    match = n.right;
    if (match ~= null) then do
      _n = match;
      continue ;
    end else do
      return n.key;
    end end 
  end;
end end

function maxKey(n) do
  if (n ~= null) then do
    return Caml_option.some(maxKey0Aux(n));
  end
   end 
end end

function maxKeyUndefined(n) do
  if (n ~= null) then do
    return maxKey0Aux(n);
  end
   end 
end end

function minKV0Aux(_n) do
  while(true) do
    n = _n;
    match = n.left;
    if (match ~= null) then do
      _n = match;
      continue ;
    end else do
      return --[[ tuple ]][
              n.key,
              n.value
            ];
    end end 
  end;
end end

function minimum(n) do
  if (n ~= null) then do
    return minKV0Aux(n);
  end
   end 
end end

function minUndefined(n) do
  if (n ~= null) then do
    return minKV0Aux(n);
  end
   end 
end end

function maxKV0Aux(_n) do
  while(true) do
    n = _n;
    match = n.right;
    if (match ~= null) then do
      _n = match;
      continue ;
    end else do
      return --[[ tuple ]][
              n.key,
              n.value
            ];
    end end 
  end;
end end

function maximum(n) do
  if (n ~= null) then do
    return maxKV0Aux(n);
  end
   end 
end end

function maxUndefined(n) do
  if (n ~= null) then do
    return maxKV0Aux(n);
  end
   end 
end end

function removeMinAuxWithRef(n, kr, vr) do
  ln = n.left;
  rn = n.right;
  kn = n.key;
  vn = n.value;
  if (ln ~= null) then do
    return bal(removeMinAuxWithRef(ln, kr, vr), kn, vn, rn);
  end else do
    kr.contents = kn;
    vr.contents = vn;
    return rn;
  end end 
end end

function isEmpty(x) do
  return x == null;
end end

function stackAllLeft(_v, _s) do
  while(true) do
    s = _s;
    v = _v;
    if (v ~= null) then do
      _s = --[[ :: ]][
        v,
        s
      ];
      _v = v.left;
      continue ;
    end else do
      return s;
    end end 
  end;
end end

function findFirstByU(n, p) do
  if (n ~= null) then do
    left = findFirstByU(n.left, p);
    if (left ~= undefined) then do
      return left;
    end else do
      v = n.key;
      d = n.value;
      pvd = p(v, d);
      if (pvd) then do
        return --[[ tuple ]][
                v,
                d
              ];
      end else do
        right = findFirstByU(n.right, p);
        if (right ~= undefined) then do
          return right;
        end else do
          return ;
        end end 
      end end 
    end end 
  end
   end 
end end

function findFirstBy(n, p) do
  return findFirstByU(n, Curry.__2(p));
end end

function forEachU(_n, f) do
  while(true) do
    n = _n;
    if (n ~= null) then do
      forEachU(n.left, f);
      f(n.key, n.value);
      _n = n.right;
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEach(n, f) do
  return forEachU(n, Curry.__2(f));
end end

function mapU(n, f) do
  if (n ~= null) then do
    newLeft = mapU(n.left, f);
    newD = f(n.value);
    newRight = mapU(n.right, f);
    return do
            key: n.key,
            value: newD,
            height: n.height,
            left: newLeft,
            right: newRight
          end;
  end else do
    return null;
  end end 
end end

function map(n, f) do
  return mapU(n, Curry.__1(f));
end end

function mapWithKeyU(n, f) do
  if (n ~= null) then do
    key = n.key;
    newLeft = mapWithKeyU(n.left, f);
    newD = f(key, n.value);
    newRight = mapWithKeyU(n.right, f);
    return do
            key: key,
            value: newD,
            height: n.height,
            left: newLeft,
            right: newRight
          end;
  end else do
    return null;
  end end 
end end

function mapWithKey(n, f) do
  return mapWithKeyU(n, Curry.__2(f));
end end

function reduceU(_m, _accu, f) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m ~= null) then do
      l = m.left;
      v = m.key;
      d = m.value;
      r = m.right;
      _accu = f(reduceU(l, accu, f), v, d);
      _m = r;
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function reduce(m, accu, f) do
  return reduceU(m, accu, Curry.__3(f));
end end

function everyU(_n, p) do
  while(true) do
    n = _n;
    if (n ~= null) then do
      if (p(n.key, n.value) and everyU(n.left, p)) then do
        _n = n.right;
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function every(n, p) do
  return everyU(n, Curry.__2(p));
end end

function someU(_n, p) do
  while(true) do
    n = _n;
    if (n ~= null) then do
      if (p(n.key, n.value) or someU(n.left, p)) then do
        return true;
      end else do
        _n = n.right;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function some(n, p) do
  return someU(n, Curry.__2(p));
end end

function addMinElement(n, k, v) do
  if (n ~= null) then do
    return bal(addMinElement(n.left, k, v), n.key, n.value, n.right);
  end else do
    return singleton(k, v);
  end end 
end end

function addMaxElement(n, k, v) do
  if (n ~= null) then do
    return bal(n.left, n.key, n.value, addMaxElement(n.right, k, v));
  end else do
    return singleton(k, v);
  end end 
end end

function join(ln, v, d, rn) do
  if (ln ~= null) then do
    if (rn ~= null) then do
      ll = ln.left;
      lv = ln.key;
      ld = ln.value;
      lr = ln.right;
      lh = ln.height;
      rl = rn.left;
      rv = rn.key;
      rd = rn.value;
      rr = rn.right;
      rh = rn.height;
      if (lh > (rh + 2 | 0)) then do
        return bal(ll, lv, ld, join(lr, v, d, rn));
      end else if (rh > (lh + 2 | 0)) then do
        return bal(join(ln, v, d, rl), rv, rd, rr);
      end else do
        return create(ln, v, d, rn);
      end end  end 
    end else do
      return addMaxElement(ln, v, d);
    end end 
  end else do
    return addMinElement(rn, v, d);
  end end 
end end

function concat(t1, t2) do
  if (t1 ~= null) then do
    if (t2 ~= null) then do
      kr = do
        contents: t2.key
      end;
      vr = do
        contents: t2.value
      end;
      t2r = removeMinAuxWithRef(t2, kr, vr);
      return join(t1, kr.contents, vr.contents, t2r);
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function concatOrJoin(t1, v, d, t2) do
  if (d ~= undefined) then do
    return join(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat(t1, t2);
  end end 
end end

function keepSharedU(n, p) do
  if (n ~= null) then do
    v = n.key;
    d = n.value;
    newLeft = keepSharedU(n.left, p);
    pvd = p(v, d);
    newRight = keepSharedU(n.right, p);
    if (pvd) then do
      return join(newLeft, v, d, newRight);
    end else do
      return concat(newLeft, newRight);
    end end 
  end else do
    return null;
  end end 
end end

function keepShared(n, p) do
  return keepSharedU(n, Curry.__2(p));
end end

function keepMapU(n, p) do
  if (n ~= null) then do
    v = n.key;
    d = n.value;
    newLeft = keepMapU(n.left, p);
    pvd = p(v, d);
    newRight = keepMapU(n.right, p);
    if (pvd ~= undefined) then do
      return join(newLeft, v, Caml_option.valFromOption(pvd), newRight);
    end else do
      return concat(newLeft, newRight);
    end end 
  end else do
    return null;
  end end 
end end

function keepMap(n, p) do
  return keepMapU(n, Curry.__2(p));
end end

function partitionSharedU(n, p) do
  if (n ~= null) then do
    key = n.key;
    value = n.value;
    match = partitionSharedU(n.left, p);
    lf = match[1];
    lt = match[0];
    pvd = p(key, value);
    match$1 = partitionSharedU(n.right, p);
    rf = match$1[1];
    rt = match$1[0];
    if (pvd) then do
      return --[[ tuple ]][
              join(lt, key, value, rt),
              concat(lf, rf)
            ];
    end else do
      return --[[ tuple ]][
              concat(lt, rt),
              join(lf, key, value, rf)
            ];
    end end 
  end else do
    return --[[ tuple ]][
            null,
            null
          ];
  end end 
end end

function partitionShared(n, p) do
  return partitionSharedU(n, Curry.__2(p));
end end

function lengthNode(n) do
  l = n.left;
  r = n.right;
  sizeL = l ~= null and lengthNode(l) or 0;
  sizeR = r ~= null and lengthNode(r) or 0;
  return (1 + sizeL | 0) + sizeR | 0;
end end

function size(n) do
  if (n ~= null) then do
    return lengthNode(n);
  end else do
    return 0;
  end end 
end end

function toListAux(_n, _accu) do
  while(true) do
    accu = _accu;
    n = _n;
    if (n ~= null) then do
      l = n.left;
      r = n.right;
      k = n.key;
      v = n.value;
      _accu = --[[ :: ]][
        --[[ tuple ]][
          k,
          v
        ],
        toListAux(r, accu)
      ];
      _n = l;
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function toList(s) do
  return toListAux(s, --[[ [] ]]0);
end end

function checkInvariantInternal(_v) do
  while(true) do
    v = _v;
    if (v ~= null) then do
      l = v.left;
      r = v.right;
      diff = treeHeight(l) - treeHeight(r) | 0;
      if (not (diff <= 2 and diff >= -2)) then do
        throw new Error("File \"belt_internalAVLtree.ml\", line 385, characters 6-12");
      end
       end 
      checkInvariantInternal(l);
      _v = r;
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function fillArrayKey(_n, _i, arr) do
  while(true) do
    i = _i;
    n = _n;
    l = n.left;
    v = n.key;
    r = n.right;
    next = l ~= null and fillArrayKey(l, i, arr) or i;
    arr[next] = v;
    rnext = next + 1 | 0;
    if (r ~= null) then do
      _i = rnext;
      _n = r;
      continue ;
    end else do
      return rnext;
    end end 
  end;
end end

function fillArrayValue(_n, _i, arr) do
  while(true) do
    i = _i;
    n = _n;
    l = n.left;
    r = n.right;
    next = l ~= null and fillArrayValue(l, i, arr) or i;
    arr[next] = n.value;
    rnext = next + 1 | 0;
    if (r ~= null) then do
      _i = rnext;
      _n = r;
      continue ;
    end else do
      return rnext;
    end end 
  end;
end end

function fillArray(_n, _i, arr) do
  while(true) do
    i = _i;
    n = _n;
    l = n.left;
    v = n.key;
    r = n.right;
    next = l ~= null and fillArray(l, i, arr) or i;
    arr[next] = --[[ tuple ]][
      v,
      n.value
    ];
    rnext = next + 1 | 0;
    if (r ~= null) then do
      _i = rnext;
      _n = r;
      continue ;
    end else do
      return rnext;
    end end 
  end;
end end

function toArray(n) do
  if (n ~= null) then do
    size = lengthNode(n);
    v = new Array(size);
    fillArray(n, 0, v);
    return v;
  end else do
    return [];
  end end 
end end

function keysToArray(n) do
  if (n ~= null) then do
    size = lengthNode(n);
    v = new Array(size);
    fillArrayKey(n, 0, v);
    return v;
  end else do
    return [];
  end end 
end end

function valuesToArray(n) do
  if (n ~= null) then do
    size = lengthNode(n);
    v = new Array(size);
    fillArrayValue(n, 0, v);
    return v;
  end else do
    return [];
  end end 
end end

function fromSortedArrayRevAux(arr, off, len) do
  local ___conditional___=(len);
  do
     if ___conditional___ = 0 then do
        return null;end end end 
     if ___conditional___ = 1 then do
        match = arr[off];
        return singleton(match[0], match[1]);end end end 
     if ___conditional___ = 2 then do
        match_000 = arr[off];
        match_001 = arr[off - 1 | 0];
        match$1 = match_001;
        match$2 = match_000;
        return do
                key: match$1[0],
                value: match$1[1],
                height: 2,
                left: singleton(match$2[0], match$2[1]),
                right: null
              end;end end end 
     if ___conditional___ = 3 then do
        match_000$1 = arr[off];
        match_001$1 = arr[off - 1 | 0];
        match_002 = arr[off - 2 | 0];
        match$3 = match_002;
        match$4 = match_001$1;
        match$5 = match_000$1;
        return do
                key: match$4[0],
                value: match$4[1],
                height: 2,
                left: singleton(match$5[0], match$5[1]),
                right: singleton(match$3[0], match$3[1])
              end;end end end 
     do
    else do
      nl = len / 2 | 0;
      left = fromSortedArrayRevAux(arr, off, nl);
      match$6 = arr[off - nl | 0];
      right = fromSortedArrayRevAux(arr, (off - nl | 0) - 1 | 0, (len - nl | 0) - 1 | 0);
      return create(left, match$6[0], match$6[1], right);
      end end
      
  end
end end

function fromSortedArrayAux(arr, off, len) do
  local ___conditional___=(len);
  do
     if ___conditional___ = 0 then do
        return null;end end end 
     if ___conditional___ = 1 then do
        match = arr[off];
        return singleton(match[0], match[1]);end end end 
     if ___conditional___ = 2 then do
        match_000 = arr[off];
        match_001 = arr[off + 1 | 0];
        match$1 = match_001;
        match$2 = match_000;
        return do
                key: match$1[0],
                value: match$1[1],
                height: 2,
                left: singleton(match$2[0], match$2[1]),
                right: null
              end;end end end 
     if ___conditional___ = 3 then do
        match_000$1 = arr[off];
        match_001$1 = arr[off + 1 | 0];
        match_002 = arr[off + 2 | 0];
        match$3 = match_002;
        match$4 = match_001$1;
        match$5 = match_000$1;
        return do
                key: match$4[0],
                value: match$4[1],
                height: 2,
                left: singleton(match$5[0], match$5[1]),
                right: singleton(match$3[0], match$3[1])
              end;end end end 
     do
    else do
      nl = len / 2 | 0;
      left = fromSortedArrayAux(arr, off, nl);
      match$6 = arr[off + nl | 0];
      right = fromSortedArrayAux(arr, (off + nl | 0) + 1 | 0, (len - nl | 0) - 1 | 0);
      return create(left, match$6[0], match$6[1], right);
      end end
      
  end
end end

function fromSortedArrayUnsafe(arr) do
  return fromSortedArrayAux(arr, 0, #arr);
end end

function cmpU(s1, s2, kcmp, vcmp) do
  len1 = size(s1);
  len2 = size(s2);
  if (len1 == len2) then do
    _e1 = stackAllLeft(s1, --[[ [] ]]0);
    _e2 = stackAllLeft(s2, --[[ [] ]]0);
    kcmp$1 = kcmp;
    vcmp$1 = vcmp;
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1 and e2) then do
        h2 = e2[0];
        h1 = e1[0];
        c = kcmp$1(h1.key, h2.key);
        if (c == 0) then do
          cx = vcmp$1(h1.value, h2.value);
          if (cx == 0) then do
            _e2 = stackAllLeft(h2.right, e2[1]);
            _e1 = stackAllLeft(h1.right, e1[1]);
            continue ;
          end else do
            return cx;
          end end 
        end else do
          return c;
        end end 
      end else do
        return 0;
      end end 
    end;
  end else if (len1 < len2) then do
    return -1;
  end else do
    return 1;
  end end  end 
end end

function cmp(s1, s2, kcmp, vcmp) do
  return cmpU(s1, s2, kcmp, Curry.__2(vcmp));
end end

function eqU(s1, s2, kcmp, veq) do
  len1 = size(s1);
  len2 = size(s2);
  if (len1 == len2) then do
    _e1 = stackAllLeft(s1, --[[ [] ]]0);
    _e2 = stackAllLeft(s2, --[[ [] ]]0);
    kcmp$1 = kcmp;
    veq$1 = veq;
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1 and e2) then do
        h2 = e2[0];
        h1 = e1[0];
        if (kcmp$1(h1.key, h2.key) == 0 and veq$1(h1.value, h2.value)) then do
          _e2 = stackAllLeft(h2.right, e2[1]);
          _e1 = stackAllLeft(h1.right, e1[1]);
          continue ;
        end else do
          return false;
        end end 
      end else do
        return true;
      end end 
    end;
  end else do
    return false;
  end end 
end end

function eq(s1, s2, kcmp, veq) do
  return eqU(s1, s2, kcmp, Curry.__2(veq));
end end

function get(_n, x, cmp) do
  while(true) do
    n = _n;
    if (n ~= null) then do
      v = n.key;
      c = cmp(x, v);
      if (c == 0) then do
        return Caml_option.some(n.value);
      end else do
        _n = c < 0 and n.left or n.right;
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getUndefined(_n, x, cmp) do
  while(true) do
    n = _n;
    if (n ~= null) then do
      v = n.key;
      c = cmp(x, v);
      if (c == 0) then do
        return n.value;
      end else do
        _n = c < 0 and n.left or n.right;
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getExn(_n, x, cmp) do
  while(true) do
    n = _n;
    if (n ~= null) then do
      v = n.key;
      c = cmp(x, v);
      if (c == 0) then do
        return n.value;
      end else do
        _n = c < 0 and n.left or n.right;
        continue ;
      end end 
    end else do
      throw new Error("getExn0");
    end end 
  end;
end end

function getWithDefault(_n, x, def, cmp) do
  while(true) do
    n = _n;
    if (n ~= null) then do
      v = n.key;
      c = cmp(x, v);
      if (c == 0) then do
        return n.value;
      end else do
        _n = c < 0 and n.left or n.right;
        continue ;
      end end 
    end else do
      return def;
    end end 
  end;
end end

function has(_n, x, cmp) do
  while(true) do
    n = _n;
    if (n ~= null) then do
      v = n.key;
      c = cmp(x, v);
      if (c == 0) then do
        return true;
      end else do
        _n = c < 0 and n.left or n.right;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function rotateWithLeftChild(k2) do
  k1 = k2.left;
  k2.left = k1.right;
  k1.right = k2;
  hlk2 = treeHeight(k2.left);
  hrk2 = treeHeight(k2.right);
  k2.height = (
    hlk2 > hrk2 and hlk2 or hrk2
  ) + 1 | 0;
  hlk1 = treeHeight(k1.left);
  hk2 = k2.height;
  k1.height = (
    hlk1 > hk2 and hlk1 or hk2
  ) + 1 | 0;
  return k1;
end end

function rotateWithRightChild(k1) do
  k2 = k1.right;
  k1.right = k2.left;
  k2.left = k1;
  hlk1 = treeHeight(k1.left);
  hrk1 = treeHeight(k1.right);
  k1.height = (
    hlk1 > hrk1 and hlk1 or hrk1
  ) + 1 | 0;
  hrk2 = treeHeight(k2.right);
  hk1 = k1.height;
  k2.height = (
    hrk2 > hk1 and hrk2 or hk1
  ) + 1 | 0;
  return k2;
end end

function doubleWithLeftChild(k3) do
  v = rotateWithRightChild(k3.left);
  k3.left = v;
  return rotateWithLeftChild(k3);
end end

function doubleWithRightChild(k2) do
  v = rotateWithLeftChild(k2.right);
  k2.right = v;
  return rotateWithRightChild(k2);
end end

function heightUpdateMutate(t) do
  hlt = treeHeight(t.left);
  hrt = treeHeight(t.right);
  t.height = (
    hlt > hrt and hlt or hrt
  ) + 1 | 0;
  return t;
end end

function balMutate(nt) do
  l = nt.left;
  r = nt.right;
  hl = treeHeight(l);
  hr = treeHeight(r);
  if (hl > (2 + hr | 0)) then do
    ll = l.left;
    lr = l.right;
    if (heightGe(ll, lr)) then do
      return heightUpdateMutate(rotateWithLeftChild(nt));
    end else do
      return heightUpdateMutate(doubleWithLeftChild(nt));
    end end 
  end else if (hr > (2 + hl | 0)) then do
    rl = r.left;
    rr = r.right;
    if (heightGe(rr, rl)) then do
      return heightUpdateMutate(rotateWithRightChild(nt));
    end else do
      return heightUpdateMutate(doubleWithRightChild(nt));
    end end 
  end else do
    nt.height = (
      hl > hr and hl or hr
    ) + 1 | 0;
    return nt;
  end end  end 
end end

function updateMutate(t, x, data, cmp) do
  if (t ~= null) then do
    k = t.key;
    c = cmp(x, k);
    if (c == 0) then do
      t.value = data;
      return t;
    end else do
      l = t.left;
      r = t.right;
      if (c < 0) then do
        ll = updateMutate(l, x, data, cmp);
        t.left = ll;
      end else do
        t.right = updateMutate(r, x, data, cmp);
      end end 
      return balMutate(t);
    end end 
  end else do
    return singleton(x, data);
  end end 
end end

function fromArray(xs, cmp) do
  len = #xs;
  if (len == 0) then do
    return null;
  end else do
    next = Belt_SortArray.strictlySortedLengthU(xs, (function (param, param$1) do
            return cmp(param[0], param$1[0]) < 0;
          end end));
    result;
    if (next >= 0) then do
      result = fromSortedArrayAux(xs, 0, next);
    end else do
      next = -next | 0;
      result = fromSortedArrayRevAux(xs, next - 1 | 0, next);
    end end 
    for i = next , len - 1 | 0 , 1 do
      match = xs[i];
      result = updateMutate(result, match[0], match[1], cmp);
    end
    return result;
  end end 
end end

function removeMinAuxWithRootMutate(nt, n) do
  rn = n.right;
  ln = n.left;
  if (ln ~= null) then do
    n.left = removeMinAuxWithRootMutate(nt, ln);
    return balMutate(n);
  end else do
    nt.key = n.key;
    return rn;
  end end 
end end

exports.copy = copy;
exports.create = create;
exports.bal = bal;
exports.singleton = singleton;
exports.updateValue = updateValue;
exports.minKey = minKey;
exports.minKeyUndefined = minKeyUndefined;
exports.maxKey = maxKey;
exports.maxKeyUndefined = maxKeyUndefined;
exports.minimum = minimum;
exports.minUndefined = minUndefined;
exports.maximum = maximum;
exports.maxUndefined = maxUndefined;
exports.removeMinAuxWithRef = removeMinAuxWithRef;
exports.isEmpty = isEmpty;
exports.stackAllLeft = stackAllLeft;
exports.findFirstByU = findFirstByU;
exports.findFirstBy = findFirstBy;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.mapU = mapU;
exports.map = map;
exports.mapWithKeyU = mapWithKeyU;
exports.mapWithKey = mapWithKey;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.join = join;
exports.concat = concat;
exports.concatOrJoin = concatOrJoin;
exports.keepSharedU = keepSharedU;
exports.keepShared = keepShared;
exports.keepMapU = keepMapU;
exports.keepMap = keepMap;
exports.partitionSharedU = partitionSharedU;
exports.partitionShared = partitionShared;
exports.lengthNode = lengthNode;
exports.size = size;
exports.toList = toList;
exports.checkInvariantInternal = checkInvariantInternal;
exports.fillArray = fillArray;
exports.toArray = toArray;
exports.keysToArray = keysToArray;
exports.valuesToArray = valuesToArray;
exports.fromSortedArrayAux = fromSortedArrayAux;
exports.fromSortedArrayRevAux = fromSortedArrayRevAux;
exports.fromSortedArrayUnsafe = fromSortedArrayUnsafe;
exports.cmpU = cmpU;
exports.cmp = cmp;
exports.eqU = eqU;
exports.eq = eq;
exports.get = get;
exports.getUndefined = getUndefined;
exports.getWithDefault = getWithDefault;
exports.getExn = getExn;
exports.has = has;
exports.fromArray = fromArray;
exports.updateMutate = updateMutate;
exports.balMutate = balMutate;
exports.removeMinAuxWithRootMutate = removeMinAuxWithRootMutate;
--[[ No side effect ]]