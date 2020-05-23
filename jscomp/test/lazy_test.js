'use strict';

var Mt = require("./mt.js");
var Lazy = require("../../lib/js/lazy.js");
var Block = require("../../lib/js/block.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var CamlinternalLazy = require("../../lib/js/camlinternalLazy.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var u = do
  contents: 3
end;

var v = Caml_obj.caml_lazy_make((function (param) do
        u.contents = 32;
        return --[ () ]--0;
      end));

function lazy_test(param) do
  var h = u.contents;
  CamlinternalLazy.force(v);
  var g = u.contents;
  return --[ tuple ]--[
          h,
          g
        ];
end

function f(param) do
  CamlinternalLazy.force(param[0]);
  var match = param[2].contents;
  if (match ~= undefined) do
    CamlinternalLazy.force(param[1]);
    var match$1 = param[2].contents;
    if (match$1 ~= undefined) do
      return 1;
    end else do
      throw [
            Caml_builtin_exceptions.match_failure,
            --[ tuple ]--[
              "lazy_test.ml",
              11,
              8
            ]
          ];
    end
  end else do
    return 0;
  end
end

var s = do
  contents: undefined
end;

var set_true = Caml_obj.caml_lazy_make((function (param) do
        s.contents = 1;
        return --[ () ]--0;
      end));

var set_false = Caml_obj.caml_lazy_make((function (param) do
        s.contents = undefined;
        return --[ () ]--0;
      end));

var h;

try do
  h = f(--[ tuple ]--[
        set_true,
        set_false,
        s
      ]);
end
catch (raw_exn)do
  var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.match_failure) do
    h = 2;
  end else do
    throw exn;
  end
end

var u_v = do
  contents: 0
end;

var u$1 = Caml_obj.caml_lazy_make((function (param) do
        u_v.contents = 2;
        return --[ () ]--0;
      end));

CamlinternalLazy.force(u$1);

var exotic = CamlinternalLazy.force;

var l_from_fun = Lazy.from_fun((function (param) do
        return 3;
      end));

var forward_test = Caml_obj.caml_lazy_make((function (param) do
        var u = 3;
        u = u + 1 | 0;
        return u;
      end));

var f005 = Caml_obj.caml_lazy_make((function (param) do
        return 6;
      end));

var f006 = Caml_obj.caml_lazy_make((function (param) do
        return (function (param) do
            return 3;
          end);
      end));

var f007 = Caml_obj.caml_lazy_make((function (param) do
        throw Caml_builtin_exceptions.not_found;
      end));

var f008 = Caml_obj.caml_lazy_make((function (param) do
        console.log("hi");
        throw Caml_builtin_exceptions.not_found;
      end));

Mt.from_pair_suites("Lazy_test", --[ :: ]--[
      --[ tuple ]--[
        "simple",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      lazy_test(--[ () ]--0),
                      --[ tuple ]--[
                        3,
                        32
                      ]
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "lazy_match",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        h,
                        2
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "lazy_force",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          u_v.contents,
                          2
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "lazy_from_fun",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            CamlinternalLazy.force(l_from_fun),
                            3
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "lazy_from_val",
                (function (param) do
                    return --[ Eq ]--Block.__(0, [
                              CamlinternalLazy.force(Lazy.from_val(3)),
                              3
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "lazy_from_val2",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                CamlinternalLazy.force(CamlinternalLazy.force(Lazy.from_val(3))),
                                3
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "lazy_from_val3",
                    (function (param) do
                        debugger;
                        return --[ Eq ]--Block.__(0, [
                                  CamlinternalLazy.force(CamlinternalLazy.force(Lazy.from_val(forward_test))),
                                  4
                                ]);
                      end)
                  ],
                  --[ [] ]--0
                ]
              ]
            ]
          ]
        ]
      ]
    ]);

exports.v = v;
exports.lazy_test = lazy_test;
exports.f = f;
exports.s = s;
exports.set_true = set_true;
exports.set_false = set_false;
exports.h = h;
exports.u_v = u_v;
exports.u = u$1;
exports.exotic = exotic;
exports.l_from_fun = l_from_fun;
exports.forward_test = forward_test;
exports.f005 = f005;
exports.f006 = f006;
exports.f007 = f007;
exports.f008 = f008;
--[ h Not a pure module ]--
