console.log = print;

Mt = require "./mt";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Caml_array = require "../../lib/js/caml_array";
Caml_int32 = require "../../lib/js/caml_int32";
Pervasives = require "../../lib/js/pervasives";
Caml_oo_curry = require "../../lib/js/caml_oo_curry";
CamlinternalOO = require "../../lib/js/camlinternalOO";

shared = {
  "move",
  "get_x",
  "get_offset"
};

shared_1 = {
  "move",
  "get_offset",
  "get_x"
};

shared_2 = {
  "move",
  "print",
  "get_x"
};

shared_3 = {"x"};

shared_4 = {
  "bump",
  "move",
  "get_x"
};

shared_5 = {
  "move",
  "get_x"
};

shared_6 = {
  "print",
  "move",
  "get_x"
};

shared_7 = {
  "bump",
  "get_x",
  "move"
};

shared_8 = {"move"};

shared_9 = {
  "register",
  "n",
  "len"
};

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_5, shared_3);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function (self$1) do
            return self$1[x];
          end end),
        move,
        (function (self$1, d) do
            self$1[x] = self$1[x] + d | 0;
            return --[[ () ]]0;
          end end)
      });
  return (function (env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

point = CamlinternalOO.make_class(shared_5, point_init);

p = Curry._2(point[0], 0, 7);

eq("File \"class3_test.ml\", line 17, characters 12-19", Caml_oo_curry.js1(291546447, 1, p), 7);

function adjusted_point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  origin = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared, shared_3);
  move = ids[0];
  get_x = ids[1];
  get_offset = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function (self$2) do
            return self$2[x];
          end end),
        get_offset,
        (function (self$2) do
            return self$2[x] - self$2[origin] | 0;
          end end),
        move,
        (function (self$2, d) do
            self$2[x] = self$2[x] + d | 0;
            return --[[ () ]]0;
          end end)
      });
  return (function (env, self, x_init_1) do
      origin_1 = Caml_int32.imul(x_init_1 / 10 | 0, 10);
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[origin] = origin_1;
      self_1[x_init] = x_init_1;
      self_1[x] = origin_1;
      return self_1;
    end end);
end end

adjusted_point = CamlinternalOO.make_class(shared_1, adjusted_point_init);

tmp = Curry._2(adjusted_point[0], 0, 31);

eq("File \"class3_test.ml\", line 28, characters 13-20", Caml_oo_curry.js1(291546447, 2, tmp), 30);

function new_init(obj_init, self, x_init) do
  return Curry._2(obj_init, self, Caml_int32.imul(x_init / 10 | 0, 10));
end end

partial_arg = point[0];

function adjusted_point2_000(param, param_1) do
  return new_init(partial_arg, param, param_1);
end end

function adjusted_point2_001(table) do
  env_init = Curry._1(point[1], table);
  return (function (envs) do
      partial_arg = Curry._1(env_init, envs);
      return (function (param, param_1) do
          return new_init(partial_arg, param, param_1);
        end end);
    end end);
end end

adjusted_point2_002 = point[2];

adjusted_point2_003 = point[3];

adjusted_point2 = --[[ class ]]{
  adjusted_point2_000,
  adjusted_point2_001,
  adjusted_point2_002,
  adjusted_point2_003
};

tmp_1 = Curry._2(adjusted_point2_000, 0, 31);

eq("File \"class3_test.ml\", line 33, characters 12-19", Caml_oo_curry.js1(291546447, 3, tmp_1), 30);

function printable_point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_6, shared_3);
  print = ids[0];
  move = ids[1];
  get_x = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function (self$4) do
            return self$4[x];
          end end),
        move,
        (function (self$4, d) do
            self$4[x] = self$4[x] + d | 0;
            return --[[ () ]]0;
          end end),
        print,
        (function (self$4) do
            return Curry._1(self$4[0][get_x], self$4);
          end end)
      });
  return (function (env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

printable_point = CamlinternalOO.make_class(shared_2, printable_point_init);

p_1 = Curry._2(printable_point[0], 0, 7);

eq("File \"class3_test.ml\", line 49, characters 11-18", Caml_oo_curry.js1(-930392019, 4, p_1), 7);

ints = do
  contents: --[[ [] ]]0
end;

__class = CamlinternalOO.create_table(shared_9);

ids = CamlinternalOO.get_method_labels(__class, shared_9);

register = ids[0];

n = ids[1];

len = ids[2];

CamlinternalOO.set_methods(__class, {
      n,
      (function (self$5) do
          return 1;
        end end),
      register,
      (function (self$5) do
          ints.contents = --[[ :: ]]{
            self$5,
            ints.contents
          };
          return --[[ () ]]0;
        end end),
      len,
      (function (self$5) do
          return List.length(ints.contents);
        end end)
    });

CamlinternalOO.init_class(__class);

my_int = CamlinternalOO.create_object_opt(0, __class);

Caml_oo_curry.js1(-794843549, 5, my_int);

Caml_oo_curry.js1(-794843549, 6, my_int);

console.log(Caml_oo_curry.js1(5393365, 7, my_int));

v = {
  0,
  3
};

function printable_point2_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  origin = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_6, shared_3);
  print = ids[0];
  move = ids[1];
  get_x = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function (self$6) do
            return self$6[x];
          end end),
        move,
        (function (self$6, d) do
            self$6[x] = self$6[x] + d | 0;
            return --[[ () ]]0;
          end end),
        print,
        (function (self$6) do
            return Pervasives.print_int(Curry._1(self$6[0][get_x], self$6));
          end end)
      });
  CamlinternalOO.add_initializer(__class, (function (self$6) do
          console.log("initializingFile \"class3_test.ml\", line 76, characters 50-57");
          return Caml_array.caml_array_set(v, 0, self$6[x]);
        end end));
  return (function (env, self, x_init_1) do
      origin_1 = Caml_int32.imul(x_init_1 / 10 | 0, 10);
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[origin] = origin_1;
      self_1[x_init] = x_init_1;
      self_1[x] = origin_1;
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

printable_point2 = CamlinternalOO.make_class(shared_2, printable_point2_init);

Curry._2(printable_point2[0], 0, 31);

eq("File \"class3_test.ml\", line 81, characters 12-19", v, {
      30,
      3
    });

function abstract_point_001(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.get_method_labels(__class, shared);
  get_x = ids[1];
  get_offset = ids[2];
  CamlinternalOO.set_method(__class, get_offset, (function (self$7) do
          return Curry._1(self$7[0][get_x], self$7) - self$7[x_init] | 0;
        end end));
  return (function (env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      return self_1;
    end end);
end end

abstract_point = --[[ class ]]{
  0,
  abstract_point_001,
  0,
  0
};

function vpoint_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_5, shared_3);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  inh = CamlinternalOO.inherits(__class, 0, shared_5, {"get_offset"}, abstract_point, true);
  obj_init = inh[0];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function (self$8) do
            return self$8[x];
          end end),
        move,
        (function (self$8, d) do
            self$8[x] = self$8[x] + d | 0;
            return --[[ () ]]0;
          end end)
      });
  return (function (env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      Curry._2(obj_init, self_1, x_init_1);
      self_1[x] = x_init_1;
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

vpoint = CamlinternalOO.make_class(shared_1, vpoint_init);

h = Curry._2(vpoint[0], 0, 3);

Caml_oo_curry.js2(-933174511, 8, h, 32);

v_1 = Caml_oo_curry.js1(-792262820, 9, h);

eq("File \"class3_test.ml\", line 107, characters 12-19", v_1, 32);

function abstract_point2_001(__class) do
  ids = CamlinternalOO.new_methods_variables(__class, shared_8, shared_3);
  move = ids[0];
  x = ids[1];
  CamlinternalOO.set_method(__class, move, (function (self$9, d) do
          self$9[x] = self$9[x] + d | 0;
          return --[[ () ]]0;
        end end));
  return (function (env, self) do
      return CamlinternalOO.create_object_opt(self, __class);
    end end);
end end

abstract_point2 = --[[ class ]]{
  0,
  abstract_point2_001,
  0,
  0
};

function point2_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  get_offset = CamlinternalOO.get_method_label(__class, "get_offset");
  inh = CamlinternalOO.inherits(__class, shared_3, 0, shared_8, abstract_point2, true);
  obj_init = inh[0];
  x = inh[1];
  CamlinternalOO.set_method(__class, get_offset, (function (self$10) do
          return self$10[x] - self$10[x_init] | 0;
        end end));
  return (function (env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      Curry._1(obj_init, self_1);
      self_1[x] = x_init_1;
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

point2 = CamlinternalOO.make_class({
      "move",
      "get_offset"
    }, point2_init);

h_1 = Curry._2(point2[0], 0, 3);

Caml_oo_curry.js2(-933174511, 10, h_1, 32);

vv = Caml_oo_curry.js1(-792262820, 11, h_1);

eq("File \"class3_test.ml\", line 128, characters 12-19", vv, 32);

function restricted_point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, {
        "move",
        "get_x",
        "bump"
      }, shared_3);
  move = ids[0];
  get_x = ids[1];
  bump = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function (self$11) do
            return self$11[x];
          end end),
        move,
        (function (self$11, d) do
            self$11[x] = self$11[x] + d | 0;
            return --[[ () ]]0;
          end end),
        bump,
        (function (self$11) do
            return Curry._2(self$11[0][move], self$11, 1);
          end end)
      });
  return (function (env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

restricted_point = CamlinternalOO.make_class({
      "bump",
      "get_x"
    }, restricted_point_init);

p_2 = Curry._2(restricted_point[0], 0, 0);

Caml_oo_curry.js1(-1054863370, 12, p_2);

h_2 = Caml_oo_curry.js1(291546447, 13, p_2);

eq("File \"class3_test.ml\", line 144, characters 12-19", h_2, 1);

function point_again_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  CamlinternalOO.get_method_label(__class, "move");
  inh = CamlinternalOO.inherits(__class, shared_3, 0, shared_7, restricted_point, true);
  obj_init = inh[0];
  return (function (env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      Curry._2(obj_init, self_1, x_1);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

point_again = CamlinternalOO.make_class(shared_4, point_again_init);

p_3 = Curry._2(point_again[0], 0, 3);

Caml_oo_curry.js2(-933174511, 14, p_3, 3);

Caml_oo_curry.js1(-1054863370, 15, p_3);

Caml_oo_curry.js1(-1054863370, 16, p_3);

hh = Caml_oo_curry.js1(291546447, 17, p_3);

eq("File \"class3_test.ml\", line 161, characters 12-19", hh, 8);

function point_again2_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  inh = CamlinternalOO.inherits(__class, shared_3, 0, shared_7, restricted_point, true);
  obj_init = inh[0];
  return (function (env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      Curry._2(obj_init, self_1, x_1);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

point_again2 = CamlinternalOO.make_class(shared_4, point_again2_init);

p_4 = Curry._2(point_again2[0], 0, 3);

Caml_oo_curry.js2(-933174511, 18, p_4, 30);

Caml_oo_curry.js1(-1054863370, 19, p_4);

Caml_oo_curry.js1(-1054863370, 20, p_4);

hhh = Caml_oo_curry.js1(291546447, 21, p_4);

eq("File \"class3_test.ml\", line 177, characters 12-19", hhh, 35);

function point_again3_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  move = CamlinternalOO.get_method_label(__class, "move");
  inh = CamlinternalOO.inherits(__class, shared_3, 0, shared_7, restricted_point, true);
  obj_init = inh[0];
  move_1 = inh[4];
  CamlinternalOO.set_method(__class, move, Curry.__1(move_1));
  return (function (env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      Curry._2(obj_init, self_1, x_1);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

point_again3 = CamlinternalOO.make_class(shared_4, point_again3_init);

p_5 = Curry._2(point_again3[0], 0, 3);

Caml_oo_curry.js2(-933174511, 22, p_5, 300);

Caml_oo_curry.js1(-1054863370, 23, p_5);

Caml_oo_curry.js1(-1054863370, 24, p_5);

hhhh = Caml_oo_curry.js1(291546447, 25, p_5);

eq("File \"class3_test.ml\", line 195, characters 12-19", hhhh, 305);

Mt.from_pair_suites("Class3_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.point = point;
exports.adjusted_point = adjusted_point;
exports.adjusted_point2 = adjusted_point2;
exports.printable_point = printable_point;
exports.my_int = my_int;
exports.printable_point2 = printable_point2;
exports.abstract_point = abstract_point;
exports.vpoint = vpoint;
exports.v = v_1;
exports.abstract_point2 = abstract_point2;
exports.point2 = point2;
exports.vv = vv;
exports.restricted_point = restricted_point;
exports.p = p_2;
exports.h = h_2;
exports.point_again = point_again;
exports.hh = hh;
exports.point_again2 = point_again2;
exports.hhh = hhh;
exports.point_again3 = point_again3;
exports.hhhh = hhhh;
--[[ point Not a pure module ]]
