'use strict';

var Mt = require("./mt.js");
var List = require("../../lib/js/list.js");
var Block = require("../../lib/js/block.js");

function length(param) do
  return 3;
end

Mt.from_pair_suites("Es6_module_test", --[ :: ]--[
      --[ tuple ]--[
        "list_length",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      List.length(--[ :: ]--[
                            1,
                            --[ :: ]--[
                              2,
                              --[ [] ]--0
                            ]
                          ]),
                      2
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "length",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        3,
                        3
                      ]);
            end)
        ],
        --[ [] ]--0
      ]
    ]);

exports.length = length;
--[  Not a pure module ]--
