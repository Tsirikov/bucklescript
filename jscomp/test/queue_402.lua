'use strict';

Curry = require("../../lib/js/curry.lua");
Caml_obj = require("../../lib/js/caml_obj.lua");
Caml_exceptions = require("../../lib/js/caml_exceptions.lua");

Empty = Caml_exceptions.create("Queue_402.Empty");

function create(param) do
  return do
          length: 0,
          tail: undefined
        end;
end end

function clear(q) do
  q.length = 0;
  q.tail = undefined;
  return --[[ () ]]0;
end end

function add(x, q) do
  if (q.length == 0) then do
    cell = { };
    cell.content = x;
    cell.next = cell;
    q.length = 1;
    q.tail = cell;
    return --[[ () ]]0;
  end else do
    tail = q.tail;
    head = tail.next;
    cell$1 = do
      content: x,
      next: head
    end;
    q.length = q.length + 1 | 0;
    tail.next = cell$1;
    q.tail = cell$1;
    return --[[ () ]]0;
  end end 
end end

function peek(q) do
  if (q.length == 0) then do
    throw Empty;
  end
   end 
  return q.tail.next.content;
end end

function take(q) do
  if (q.length == 0) then do
    throw Empty;
  end
   end 
  q.length = q.length - 1 | 0;
  tail = q.tail;
  head = tail.next;
  if (head == tail) then do
    q.tail = undefined;
  end else do
    tail.next = head.next;
  end end 
  return head.content;
end end

function copy(q) do
  if (q.length == 0) then do
    return do
            length: 0,
            tail: undefined
          end;
  end else do
    tail = q.tail;
    tail$prime = { };
    Caml_obj.caml_update_dummy(tail$prime, do
          content: tail.content,
          next: tail$prime
        end);
    copy$1 = function (_prev, _cell) do
      while(true) do
        cell = _cell;
        prev = _prev;
        if (cell ~= tail) then do
          res = do
            content: cell.content,
            next: tail$prime
          end;
          prev.next = res;
          _cell = cell.next;
          _prev = res;
          continue ;
        end else do
          return 0;
        end end 
      end;
    end end;
    copy$1(tail$prime, tail.next);
    return do
            length: q.length,
            tail: tail$prime
          end;
  end end 
end end

function is_empty(q) do
  return q.length == 0;
end end

function length(q) do
  return q.length;
end end

function iter(f, q) do
  if (q.length > 0) then do
    tail = q.tail;
    _cell = tail.next;
    while(true) do
      cell = _cell;
      Curry._1(f, cell.content);
      if (cell ~= tail) then do
        _cell = cell.next;
        continue ;
      end else do
        return 0;
      end end 
    end;
  end else do
    return 0;
  end end 
end end

function fold(f, accu, q) do
  if (q.length == 0) then do
    return accu;
  end else do
    tail = q.tail;
    _accu = accu;
    _cell = tail.next;
    while(true) do
      cell = _cell;
      accu$1 = _accu;
      accu$2 = Curry._2(f, accu$1, cell.content);
      if (cell == tail) then do
        return accu$2;
      end else do
        _cell = cell.next;
        _accu = accu$2;
        continue ;
      end end 
    end;
  end end 
end end

function transfer(q1, q2) do
  length1 = q1.length;
  if (length1 > 0) then do
    tail1 = q1.tail;
    clear(q1);
    if (q2.length > 0) then do
      tail2 = q2.tail;
      head1 = tail1.next;
      head2 = tail2.next;
      tail1.next = head2;
      tail2.next = head1;
    end
     end 
    q2.length = q2.length + length1 | 0;
    q2.tail = tail1;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

push = add;

top = peek;

pop = take;

exports.Empty = Empty;
exports.create = create;
exports.clear = clear;
exports.add = add;
exports.push = push;
exports.peek = peek;
exports.top = top;
exports.take = take;
exports.pop = pop;
exports.copy = copy;
exports.is_empty = is_empty;
exports.length = length;
exports.iter = iter;
exports.fold = fold;
exports.transfer = transfer;
--[[ No side effect ]]
