

import * as Bytes from "./bytes.lua";
import * as Curry from "./curry.lua";
import * as __String from "./string.lua";
import * as Caml_bytes from "./caml_bytes.lua";
import * as Pervasives from "./pervasives.lua";
import * as Caml_string from "./caml_string.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function create(n) do
  n$1 = n < 1 and 1 or n;
  s = Caml_bytes.caml_create_bytes(n$1);
  return do
          buffer: s,
          position: 0,
          length: n$1,
          initial_buffer: s
        end;
end end

function contents(b) do
  return Bytes.sub_string(b.buffer, 0, b.position);
end end

function to_bytes(b) do
  return Bytes.sub(b.buffer, 0, b.position);
end end

function sub(b, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (b.position - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.sub"
        ];
  end
   end 
  return Bytes.sub_string(b.buffer, ofs, len);
end end

function blit(src, srcoff, dst, dstoff, len) do
  if (len < 0 or srcoff < 0 or srcoff > (src.position - len | 0) or dstoff < 0 or dstoff > (#dst - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.blit"
        ];
  end
   end 
  return Caml_bytes.caml_blit_bytes(src.buffer, srcoff, dst, dstoff, len);
end end

function nth(b, ofs) do
  if (ofs < 0 or ofs >= b.position) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.nth"
        ];
  end
   end 
  return b.buffer[ofs];
end end

function length(b) do
  return b.position;
end end

function clear(b) do
  b.position = 0;
  return --[[ () ]]0;
end end

function reset(b) do
  b.position = 0;
  b.buffer = b.initial_buffer;
  b.length = #b.buffer;
  return --[[ () ]]0;
end end

function resize(b, more) do
  len = b.length;
  new_len = len;
  while((b.position + more | 0) > new_len) do
    new_len = (new_len << 1);
  end;
  new_buffer = Caml_bytes.caml_create_bytes(new_len);
  Bytes.blit(b.buffer, 0, new_buffer, 0, b.position);
  b.buffer = new_buffer;
  b.length = new_len;
  return --[[ () ]]0;
end end

function add_char(b, c) do
  pos = b.position;
  if (pos >= b.length) then do
    resize(b, 1);
  end
   end 
  b.buffer[pos] = c;
  b.position = pos + 1 | 0;
  return --[[ () ]]0;
end end

function add_utf_8_uchar(b, u) do
  u$1 = u;
  if (u$1 < 0) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "buffer.ml",
            90,
            19
          ]
        ];
  end
   end 
  if (u$1 <= 127) then do
    return add_char(b, u$1);
  end else if (u$1 <= 2047) then do
    pos = b.position;
    if ((pos + 2 | 0) > b.length) then do
      resize(b, 2);
    end
     end 
    b.buffer[pos] = 192 | (u$1 >>> 6);
    b.buffer[pos + 1 | 0] = 128 | u$1 & 63;
    b.position = pos + 2 | 0;
    return --[[ () ]]0;
  end else if (u$1 <= 65535) then do
    pos$1 = b.position;
    if ((pos$1 + 3 | 0) > b.length) then do
      resize(b, 3);
    end
     end 
    b.buffer[pos$1] = 224 | (u$1 >>> 12);
    b.buffer[pos$1 + 1 | 0] = 128 | (u$1 >>> 6) & 63;
    b.buffer[pos$1 + 2 | 0] = 128 | u$1 & 63;
    b.position = pos$1 + 3 | 0;
    return --[[ () ]]0;
  end else if (u$1 <= 1114111) then do
    pos$2 = b.position;
    if ((pos$2 + 4 | 0) > b.length) then do
      resize(b, 4);
    end
     end 
    b.buffer[pos$2] = 240 | (u$1 >>> 18);
    b.buffer[pos$2 + 1 | 0] = 128 | (u$1 >>> 12) & 63;
    b.buffer[pos$2 + 2 | 0] = 128 | (u$1 >>> 6) & 63;
    b.buffer[pos$2 + 3 | 0] = 128 | u$1 & 63;
    b.position = pos$2 + 4 | 0;
    return --[[ () ]]0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "buffer.ml",
            123,
            8
          ]
        ];
  end end  end  end  end 
end end

function add_utf_16be_uchar(b, u) do
  u$1 = u;
  if (u$1 < 0) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "buffer.ml",
            126,
            19
          ]
        ];
  end
   end 
  if (u$1 <= 65535) then do
    pos = b.position;
    if ((pos + 2 | 0) > b.length) then do
      resize(b, 2);
    end
     end 
    b.buffer[pos] = (u$1 >>> 8);
    b.buffer[pos + 1 | 0] = u$1 & 255;
    b.position = pos + 2 | 0;
    return --[[ () ]]0;
  end else if (u$1 <= 1114111) then do
    u$prime = u$1 - 65536 | 0;
    hi = 55296 | (u$prime >>> 10);
    lo = 56320 | u$prime & 1023;
    pos$1 = b.position;
    if ((pos$1 + 4 | 0) > b.length) then do
      resize(b, 4);
    end
     end 
    b.buffer[pos$1] = (hi >>> 8);
    b.buffer[pos$1 + 1 | 0] = hi & 255;
    b.buffer[pos$1 + 2 | 0] = (lo >>> 8);
    b.buffer[pos$1 + 3 | 0] = lo & 255;
    b.position = pos$1 + 4 | 0;
    return --[[ () ]]0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "buffer.ml",
            144,
            8
          ]
        ];
  end end  end 
end end

function add_utf_16le_uchar(b, u) do
  u$1 = u;
  if (u$1 < 0) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "buffer.ml",
            147,
            19
          ]
        ];
  end
   end 
  if (u$1 <= 65535) then do
    pos = b.position;
    if ((pos + 2 | 0) > b.length) then do
      resize(b, 2);
    end
     end 
    b.buffer[pos] = u$1 & 255;
    b.buffer[pos + 1 | 0] = (u$1 >>> 8);
    b.position = pos + 2 | 0;
    return --[[ () ]]0;
  end else if (u$1 <= 1114111) then do
    u$prime = u$1 - 65536 | 0;
    hi = 55296 | (u$prime >>> 10);
    lo = 56320 | u$prime & 1023;
    pos$1 = b.position;
    if ((pos$1 + 4 | 0) > b.length) then do
      resize(b, 4);
    end
     end 
    b.buffer[pos$1] = hi & 255;
    b.buffer[pos$1 + 1 | 0] = (hi >>> 8);
    b.buffer[pos$1 + 2 | 0] = lo & 255;
    b.buffer[pos$1 + 3 | 0] = (lo >>> 8);
    b.position = pos$1 + 4 | 0;
    return --[[ () ]]0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "buffer.ml",
            165,
            8
          ]
        ];
  end end  end 
end end

function add_substring(b, s, offset, len) do
  if (offset < 0 or len < 0 or offset > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.add_substring/add_subbytes"
        ];
  end
   end 
  new_position = b.position + len | 0;
  if (new_position > b.length) then do
    resize(b, len);
  end
   end 
  Bytes.blit_string(s, offset, b.buffer, b.position, len);
  b.position = new_position;
  return --[[ () ]]0;
end end

function add_subbytes(b, s, offset, len) do
  return add_substring(b, Caml_bytes.bytes_to_string(s), offset, len);
end end

function add_string(b, s) do
  len = #s;
  new_position = b.position + len | 0;
  if (new_position > b.length) then do
    resize(b, len);
  end
   end 
  Bytes.blit_string(s, 0, b.buffer, b.position, len);
  b.position = new_position;
  return --[[ () ]]0;
end end

function add_bytes(b, s) do
  return add_string(b, Caml_bytes.bytes_to_string(s));
end end

function add_buffer(b, bs) do
  return add_subbytes(b, bs.buffer, 0, bs.position);
end end

function add_channel(b, ic, len) do
  if (len < 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.add_channel"
        ];
  end
   end 
  if ((b.position + len | 0) > b.length) then do
    resize(b, len);
  end
   end 
  b$1 = b;
  ic$1 = ic;
  _len = len;
  while(true) do
    len$1 = _len;
    if (len$1 > 0) then do
      n = Pervasives.input(ic$1, b$1.buffer, b$1.position, len$1);
      b$1.position = b$1.position + n | 0;
      if (n == 0) then do
        throw Caml_builtin_exceptions.end_of_file;
      end
       end 
      _len = len$1 - n | 0;
      continue ;
    end else do
      return 0;
    end end 
  end;
end end

function output_buffer(oc, b) do
  return Pervasives.output(oc, b.buffer, 0, b.position);
end end

function closing(param) do
  if (param ~= 40) then do
    if (param ~= 123) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "buffer.ml",
              216,
              9
            ]
          ];
    end else do
      return --[[ "}" ]]125;
    end end 
  end else do
    return --[[ ")" ]]41;
  end end 
end end

function advance_to_closing(opening, closing, k, s, start) do
  _k = k;
  _i = start;
  lim = #s;
  while(true) do
    i = _i;
    k$1 = _k;
    if (i >= lim) then do
      throw Caml_builtin_exceptions.not_found;
    end
     end 
    if (Caml_string.get(s, i) == opening) then do
      _i = i + 1 | 0;
      _k = k$1 + 1 | 0;
      continue ;
    end else if (Caml_string.get(s, i) == closing) then do
      if (k$1 == 0) then do
        return i;
      end else do
        _i = i + 1 | 0;
        _k = k$1 - 1 | 0;
        continue ;
      end end 
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end end

function advance_to_non_alpha(s, start) do
  _i = start;
  lim = #s;
  while(true) do
    i = _i;
    if (i >= lim) then do
      return lim;
    end else do
      match = Caml_string.get(s, i);
      if (match >= 91) then do
        if (match >= 97) then do
          if (match >= 123) then do
            return i;
          end
           end 
        end else if (match ~= 95) then do
          return i;
        end
         end  end 
      end else if (match >= 58) then do
        if (match < 65) then do
          return i;
        end
         end 
      end else if (match < 48) then do
        return i;
      end
       end  end  end 
      _i = i + 1 | 0;
      continue ;
    end end 
  end;
end end

function find_ident(s, start, lim) do
  if (start >= lim) then do
    throw Caml_builtin_exceptions.not_found;
  end
   end 
  c = Caml_string.get(s, start);
  if (c ~= 40 and c ~= 123) then do
    stop = advance_to_non_alpha(s, start + 1 | 0);
    return --[[ tuple ]][
            __String.sub(s, start, stop - start | 0),
            stop
          ];
  end
   end 
  new_start = start + 1 | 0;
  stop$1 = advance_to_closing(c, closing(c), 0, s, new_start);
  return --[[ tuple ]][
          __String.sub(s, new_start, (stop$1 - start | 0) - 1 | 0),
          stop$1 + 1 | 0
        ];
end end

function add_substitute(b, f, s) do
  lim = #s;
  _previous = --[[ " " ]]32;
  _i = 0;
  while(true) do
    i = _i;
    previous = _previous;
    if (i < lim) then do
      current = Caml_string.get(s, i);
      if (current ~= 36) then do
        if (previous == --[[ "\\" ]]92) then do
          add_char(b, --[[ "\\" ]]92);
          add_char(b, current);
          _i = i + 1 | 0;
          _previous = --[[ " " ]]32;
          continue ;
        end else if (current ~= 92) then do
          add_char(b, current);
          _i = i + 1 | 0;
          _previous = current;
          continue ;
        end else do
          _i = i + 1 | 0;
          _previous = current;
          continue ;
        end end  end 
      end else if (previous == --[[ "\\" ]]92) then do
        add_char(b, current);
        _i = i + 1 | 0;
        _previous = --[[ " " ]]32;
        continue ;
      end else do
        j = i + 1 | 0;
        match = find_ident(s, j, lim);
        add_string(b, Curry._1(f, match[0]));
        _i = match[1];
        _previous = --[[ " " ]]32;
        continue ;
      end end  end 
    end else if (previous == --[[ "\\" ]]92) then do
      return add_char(b, previous);
    end else do
      return 0;
    end end  end 
  end;
end end

function truncate(b, len) do
  if (len < 0 or len > b.position) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.truncate"
        ];
  end
   end 
  b.position = len;
  return --[[ () ]]0;
end end

export do
  create ,
  contents ,
  to_bytes ,
  sub ,
  blit ,
  nth ,
  length ,
  clear ,
  reset ,
  add_char ,
  add_utf_8_uchar ,
  add_utf_16le_uchar ,
  add_utf_16be_uchar ,
  add_string ,
  add_bytes ,
  add_substring ,
  add_subbytes ,
  add_substitute ,
  add_buffer ,
  add_channel ,
  output_buffer ,
  truncate ,
  
end
--[[ No side effect ]]