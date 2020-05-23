'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Caml_option = require("../../lib/js/caml_option.js");
var Js_undefined = require("../../lib/js/js_undefined.js");

var suites_000 = --[ tuple ]--[
  "toOption - empty",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                undefined,
                undefined
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "toOption - 'a",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  --[ () ]--0,
                  Caml_option.undefined_to_opt(--[ () ]--0)
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "return",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    "something",
                    Caml_option.undefined_to_opt("something")
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "test - empty",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      true,
                      true
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "test - 'a",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        false,
                        false
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "bind - empty",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          undefined,
                          Js_undefined.bind(undefined, (function (v) do
                                  return v;
                                end))
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "bind - 'a",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            4,
                            Js_undefined.bind(2, (function (n) do
                                    return (n << 1);
                                  end))
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "iter - empty",
                (function (param) do
                    var hit = do
                      contents: false
                    end;
                    Js_undefined.iter(undefined, (function (param) do
                            hit.contents = true;
                            return --[ () ]--0;
                          end));
                    return --[ Eq ]--Block.__(0, [
                              false,
                              hit.contents
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "iter - 'a",
                  (function (param) do
                      var hit = do
                        contents: 0
                      end;
                      Js_undefined.iter(2, (function (v) do
                              hit.contents = v;
                              return --[ () ]--0;
                            end));
                      return --[ Eq ]--Block.__(0, [
                                2,
                                hit.contents
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "fromOption - None",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  undefined,
                                  Js_undefined.fromOption(undefined)
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "fromOption - Some",
                      (function (param) do
                          return --[ Eq ]--Block.__(0, [
                                    2,
                                    Js_undefined.fromOption(2)
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
      ]
    ]
  ]
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_undefined_test", suites);

exports.suites = suites;
--[  Not a pure module ]--
