/**
 * @file Assembler w domu
 * @author Trenek
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "pmc",

  extras: ($) => [
    /\s/, // whitespace
    $.comment,
  ],

  rules: {
    source_file: $ => repeat($.line),
    line: $ => seq(
      $.MEM, 
      $.leftBracket,
      $.number,
      $.rightBracket,
      $.thing,
      optional(choice(
        $.number,
        seq(
          $.instruction,
          $.mode,
          $.number
        ),
        $.stop
      )),
    ),

    MEM: $ => 'MEM',
    leftBracket: $ => '[',
    rightBracket: $ => ']',
    thing: $ => ':',

    stop: $ => 'stop',

    number: $ => /\d+/,
    instruction: $ => choice(
      'load',
      'store',
      'jump',
      'jneg',
      'jzero',
      'add',
      'sub',
      'mult',
      'div',
      'and',
      'or',
      'not',
      'cmp',
      'shz',
      'shc'
    ),
    mode: $ => choice(
      'C',
      'D',
      'I',
      'N'
    ),
    comment: ($) => token(seq(";", /.*/)),
  },
});
