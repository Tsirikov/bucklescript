--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Js_null = require "../../lib/js/js_null.lua";
Caml_option = require "../../lib/js/caml_option.lua";

suites_000 = --[[ tuple ]][
  "toOption - empty",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                undefined,
                undefined
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "toOption - 'a",
    (function (param) do
        return --[[ Eq ]]Block.__(0, [
                  --[[ () ]]0,
                  Caml_option.null_to_opt(--[[ () ]]0)
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "return",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    "something",
                    Caml_option.null_to_opt("something")
                  ]);
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "test - empty",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      true,
                      true
                    ]);
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "test - 'a",
          (function (param) do
              return --[[ Eq ]]Block.__(0, [
                        false,
                        false
                      ]);
            end end)
        ],
        --[[ :: ]][
          --[[ tuple ]][
            "bind - empty",
            (function (param) do
                return --[[ StrictEq ]]Block.__(2, [
                          null,
                          Js_null.bind(null, (function (v) do
                                  return v;
                                end end))
                        ]);
              end end)
          ],
          --[[ :: ]][
            --[[ tuple ]][
              "bind - 'a",
              (function (param) do
                  return --[[ StrictEq ]]Block.__(2, [
                            4,
                            Js_null.bind(2, (function (n) do
                                    return (n << 1);
                                  end end))
                          ]);
                end end)
            ],
            --[[ :: ]][
              --[[ tuple ]][
                "iter - empty",
                (function (param) do
                    hit = do
                      contents: false
                    end;
                    Js_null.iter(null, (function (param) do
                            hit.contents = true;
                            return --[[ () ]]0;
                          end end));
                    return --[[ Eq ]]Block.__(0, [
                              false,
                              hit.contents
                            ]);
                  end end)
              ],
              --[[ :: ]][
                --[[ tuple ]][
                  "iter - 'a",
                  (function (param) do
                      hit = do
                        contents: 0
                      end;
                      Js_null.iter(2, (function (v) do
                              hit.contents = v;
                              return --[[ () ]]0;
                            end end));
                      return --[[ Eq ]]Block.__(0, [
                                2,
                                hit.contents
                              ]);
                    end end)
                ],
                --[[ :: ]][
                  --[[ tuple ]][
                    "fromOption - None",
                    (function (param) do
                        return --[[ Eq ]]Block.__(0, [
                                  null,
                                  Js_null.fromOption(undefined)
                                ]);
                      end end)
                  ],
                  --[[ :: ]][
                    --[[ tuple ]][
                      "fromOption - Some",
                      (function (param) do
                          return --[[ Eq ]]Block.__(0, [
                                    2,
                                    Js_null.fromOption(2)
                                  ]);
                        end end)
                    ],
                    --[[ [] ]]0
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

suites = --[[ :: ]][
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_null_test", suites);

exports.suites = suites;
--[[  Not a pure module ]]