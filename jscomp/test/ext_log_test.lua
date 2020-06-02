--[['use strict';]]

Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Format = require "../../lib/js/format.lua";
Pervasives = require "../../lib/js/pervasives.lua";

function err(str, f) do
  return Curry._1(Format.fprintf(Format.err_formatter, Pervasives.$caret$caret(--[[ Format ]][
                      --[[ String ]]Block.__(2, [
                          --[[ No_padding ]]0,
                          --[[ Char_literal ]]Block.__(12, [
                              --[[ " " ]]32,
                              --[[ End_of_format ]]0
                            ])
                        ]),
                      "%s "
                    ], Pervasives.$caret$caret(f, --[[ Format ]][
                          --[[ Formatting_lit ]]Block.__(17, [
                              --[[ Flush_newline ]]4,
                              --[[ End_of_format ]]0
                            ]),
                          "@."
                        ]))), str);
end end

function ierr(b, str, f) do
  if (b) then do
    return Curry._1(Format.fprintf(Format.err_formatter, Pervasives.$caret$caret(--[[ Format ]][
                        --[[ String ]]Block.__(2, [
                            --[[ No_padding ]]0,
                            --[[ Char_literal ]]Block.__(12, [
                                --[[ " " ]]32,
                                --[[ End_of_format ]]0
                              ])
                          ]),
                        "%s "
                      ], f)), str);
  end else do
    return Format.ifprintf(Format.err_formatter, Pervasives.$caret$caret(--[[ Format ]][
                      --[[ String ]]Block.__(2, [
                          --[[ No_padding ]]0,
                          --[[ Char_literal ]]Block.__(12, [
                              --[[ " " ]]32,
                              --[[ End_of_format ]]0
                            ])
                        ]),
                      "%s "
                    ], f))(str);
  end end 
end end

function warn(str, f) do
  return Curry._1(Format.fprintf(Format.err_formatter, Pervasives.$caret$caret(--[[ Format ]][
                      --[[ String_literal ]]Block.__(11, [
                          "WARN: ",
                          --[[ String ]]Block.__(2, [
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, [
                                  --[[ " " ]]32,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ]),
                      "WARN: %s "
                    ], Pervasives.$caret$caret(f, --[[ Format ]][
                          --[[ Formatting_lit ]]Block.__(17, [
                              --[[ Flush_newline ]]4,
                              --[[ End_of_format ]]0
                            ]),
                          "@."
                        ]))), str);
end end

function iwarn(b, str, f) do
  if (b) then do
    return Curry._1(Format.fprintf(Format.err_formatter, Pervasives.$caret$caret(--[[ Format ]][
                        --[[ String_literal ]]Block.__(11, [
                            "WARN: ",
                            --[[ String ]]Block.__(2, [
                                --[[ No_padding ]]0,
                                --[[ Char_literal ]]Block.__(12, [
                                    --[[ " " ]]32,
                                    --[[ End_of_format ]]0
                                  ])
                              ])
                          ]),
                        "WARN: %s "
                      ], f)), str);
  end else do
    return Format.ifprintf(Format.err_formatter, Pervasives.$caret$caret(--[[ Format ]][
                      --[[ String_literal ]]Block.__(11, [
                          "WARN: ",
                          --[[ String ]]Block.__(2, [
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, [
                                  --[[ " " ]]32,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ]),
                      "WARN: %s "
                    ], f))(str);
  end end 
end end

function info(str, f) do
  return Curry._1(Format.fprintf(Format.err_formatter, Pervasives.$caret$caret(--[[ Format ]][
                      --[[ String_literal ]]Block.__(11, [
                          "INFO: ",
                          --[[ String ]]Block.__(2, [
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, [
                                  --[[ " " ]]32,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ]),
                      "INFO: %s "
                    ], f)), str);
end end

function iinfo(b, str, f) do
  return Curry._1(Format.fprintf(Format.err_formatter, Pervasives.$caret$caret(--[[ Format ]][
                      --[[ String_literal ]]Block.__(11, [
                          "INFO: ",
                          --[[ String ]]Block.__(2, [
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, [
                                  --[[ " " ]]32,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ]),
                      "INFO: %s "
                    ], f)), str);
end end

exports.err = err;
exports.ierr = ierr;
exports.warn = warn;
exports.iwarn = iwarn;
exports.info = info;
exports.iinfo = iinfo;
--[[ Format Not a pure module ]]