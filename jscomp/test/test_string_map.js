'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function height(param) do
  if (param) do
    return param[--[ h ]--4];
  end else do
    return 0;
  end
end

function create(l, x, d, r) do
  var hl = height(l);
  var hr = height(r);
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--x,
          --[ d ]--d,
          --[ r ]--r,
          --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal(l, x, d, r) do
  var hl = l ? l[--[ h ]--4] : 0;
  var hr = r ? r[--[ h ]--4] : 0;
  if (hl > (hr + 2 | 0)) do
    if (l) do
      var lr = l[--[ r ]--3];
      var ld = l[--[ d ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height(ll) >= height(lr)) do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) do
        return create(create(ll, lv, ld, lr[--[ l ]--0]), lr[--[ v ]--1], lr[--[ d ]--2], create(lr[--[ r ]--3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end
  end else if (hr > (hl + 2 | 0)) do
    if (r) do
      var rr = r[--[ r ]--3];
      var rd = r[--[ d ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height(rr) >= height(rl)) do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) do
        return create(create(l, x, d, rl[--[ l ]--0]), rl[--[ v ]--1], rl[--[ d ]--2], create(rl[--[ r ]--3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end
  end else do
    return --[ Node ]--[
            --[ l ]--l,
            --[ v ]--x,
            --[ d ]--d,
            --[ r ]--r,
            --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end
end

function add(x, data, m) do
  if (m) do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) do
      if (d == data) do
        return m;
      end else do
        return --[ Node ]--[
                --[ l ]--l,
                --[ v ]--x,
                --[ d ]--data,
                --[ r ]--r,
                --[ h ]--m[--[ h ]--4]
              ];
      end
    end else if (c < 0) do
      var ll = add(x, data, l);
      if (l == ll) do
        return m;
      end else do
        return bal(ll, v, d, r);
      end
    end else do
      var rr = add(x, data, r);
      if (r == rr) do
        return m;
      end else do
        return bal(l, v, d, rr);
      end
    end
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ d ]--data,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end
end

function find(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) do
        return param[--[ d ]--2];
      end else do
        _param = c < 0 ? param[--[ l ]--0] : param[--[ r ]--3];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function timing(label, f) do
  console.time(label);
  Curry._1(f, --[ () ]--0);
  console.timeEnd(label);
  return --[ () ]--0;
end

function assertion_test(param) do
  var m = do
    contents: --[ Empty ]--0
  end;
  timing("building", (function (param) do
          for(var i = 0; i <= 1000000; ++i)do
            m.contents = add(String(i), String(i), m.contents);
          end
          return --[ () ]--0;
        end));
  return timing("querying", (function (param) do
                for(var i = 0; i <= 1000000; ++i)do
                  find(String(i), m.contents);
                end
                return --[ () ]--0;
              end));
end

exports.assertion_test = assertion_test;
--[ No side effect ]--
