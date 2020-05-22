'use strict';

var List = require("../../lib/js/list.js");
var Curry = require("../../lib/js/curry.js");

function from_pair_suites(name, suites) {
  console.log(--[ tuple ]--[
        name,
        "testing"
      ]);
  return List.iter((function (param) {
                var name = param[0];
                var match = Curry._1(param[1], --[ () ]--0);
                switch (match.tag | 0) {
                  case --[ Eq ]--0 :
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "eq?",
                            match[1]
                          ]);
                      return --[ () ]--0;
                  case --[ Neq ]--1 :
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "neq?",
                            match[1]
                          ]);
                      return --[ () ]--0;
                  case --[ StrictEq ]--2 :
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "strict_eq?",
                            match[1]
                          ]);
                      return --[ () ]--0;
                  case --[ StrictNeq ]--3 :
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "strict_neq?",
                            match[1]
                          ]);
                      return --[ () ]--0;
                  case --[ Ok ]--4 :
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "ok?"
                          ]);
                      return --[ () ]--0;
                  case --[ Approx ]--5 :
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "~",
                            match[1]
                          ]);
                      return --[ () ]--0;
                  case --[ ApproxThreshold ]--6 :
                      console.log(--[ tuple ]--[
                            name,
                            match[1],
                            "~",
                            match[2],
                            " (",
                            match[0],
                            ")"
                          ]);
                      return --[ () ]--0;
                  case --[ ThrowAny ]--7 :
                      return --[ () ]--0;
                  case --[ Fail ]--8 :
                      console.log("failed");
                      return --[ () ]--0;
                  case --[ FailWith ]--9 :
                      console.log("failed: " .. match[0]);
                      return --[ () ]--0;
                  
                }
              }), suites);
}

exports.from_pair_suites = from_pair_suites;
--[ No side effect ]--
