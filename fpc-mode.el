;;; fpc-mode.el --- A major mode for the Free Pascal programming language -*- lexical-binding: t -*-

;; Version: 0.0.1
;; Author: XXIV
;; Keywords: files, fpc
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/thechampagne/fpc-mode

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for the Free Pascal programming language.

;;;; Installation

;; You can use built-in package manager (package.el) or do everything by your hands.

;;;;; Using package manager

;; Add the following to your Emacs config file

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; Then use `M-x package-install RET fpc-mode RET` to install the mode.
;; Use `M-x fpc-mode` to change your current mode.

;;;;; Manual

;; Download the mode to your local directory.  You can do it through `git clone` command:

;; git clone git://github.com/thechampagne/fpc-mode.git

;; Then add path to fpc-mode to load-path list — add the following to your Emacs config file

;; (add-to-list 'load-path
;; 	     "/path/to/fpc-mode/")
;; (require 'fpc-mode)

;; Use `M-x fpc-mode` to change your current mode.

;;; Code:


(defconst fpc-keywords
  '(;; Turbo Pascal
    "absolute" "and" "array" "asm" "begin" "break" "case" "const"
    "constructor" "continue" "destructor" "div" "do" "downto" "else" "end"
    "file" "for" "function" "goto" "if" "implementation" "in" "inherited"
    "inline" "interface" "label" "mod" "not" "object" "of" ;; "nil"
    "on" "operator" "or" "packed" "procedure" "program" "record" "reintroduce"
    "repeat" "self" "set" "shl" "shr" "then" "to" ;; "string"
    "type" "unit" "until" "uses" "var" "while" "with" "xor"

    ;; Delphi
    "as" "class" "except" "exports" "finalization" "finally" "initialization"
    "is" "library" "property" "raise" "threadvar" "try" ;; "on"

    ;; Object Pascal
    "constref" "out"

    ;; Free Pascal
    ;; "false" "true" "break" "continue"
    "dispose" "exit" "new"))


(defconst fpc-modifiers
  '("absolute" "abstract" "alias"
    "assembler" "cdecl" "cppdecl"
    "default" "export" "external"
    "forward" "generic" "index"
    "local" "name" "nostackframe"
    "oldfpccall" "override" "pascal"
    "private" "protected" "public"
    "published" "register" "reintroduce"
    "safecall" "softfloat" "specialize"
    "stdcall" "virtual"))

(defconst fpc-builtins
  '("abs" "arctan" "cos"
    "eof" "eoln" "exp"
    "input" "ln" "maxint"
    "odd" ;; "dispose" "new"
    "ord" "output" "pack"
    "page" "pred" "read"
    "readln" "reset" "rewrite"
    "round" "sin" "sqr" "sqrt"
    "succ" "trunc" "write"
    "writeln"))


(defconst fpc-data-types
  '(;; Integer types
    "byte" "shortint"
    "smallint" "word"
    "integer" "cardinal"
    "longint" "longword"
    "int64" "qword"

    ;; Real types
    "real" "single"
    "double" "extended"
    "comp" "currency"

    ;; Boolean types
    "boolean" "bytebool"
    "wordbool" "longbool"

    ;; Character types
    "char" "widechar"
    "ansichar"

    ;; String types
    "string" "shortstring"
    "ansistring" "widestring"
    "unicodestring" "pchar"

    ;; Others
    "pointer" "text"))


(defconst fpc-constants
  '("false" "true" "nil"))


(defconst fpc-font-lock-keywords
  (list
   `(,(regexp-opt fpc-constants 'words) . font-lock-constant-face)
   `(,(regexp-opt fpc-keywords 'symbols) . font-lock-keyword-face)
   `(,(regexp-opt fpc-modifiers 'symbols) . font-lock-keyword-face)
   `(,(regexp-opt fpc-builtins 'words) . font-lock-builtin-face)
   `(,(regexp-opt fpc-data-types 'words) . font-lock-type-face)
   `("\\_<\\(program\\)[[:space:]]*\\([_a-zA-Z][_a-zA-Z0-9]*\\)" (2 font-lock-constant-face))
   `("\\_<\\([_a-zA-Z][_a-zA-Z0-9]*\\)[[:space:]]*=" (1 font-lock-type-face))
   `("\\_<\\(function\\|procedure\\)[[:space:]]*\\([_a-zA-Z][_a-zA-Z0-9]*\\)" (2 font-lock-function-name-face))
   `("\\_<\\([_a-zA-Z][_a-zA-Z0-9]*\\)[[:space:]]*:[[:space:]]*\\([_a-zA-Z][_a-zA-Z0-9]*\\)" (1 font-lock-variable-name-face) (2 font-lock-type-face))
   `("\\_<\\([_a-zA-Z][_a-zA-Z0-9]*\\)[[:space:]]*:=" (1 font-lock-variable-name-face))))

;;;###autoload
(define-derived-mode fpc-mode pascal-mode "Free Pascal"
  "A major mode for the Free Pascal programming language."
  (setq-local font-lock-defaults '(fpc-font-lock-keywords nil 'case-fold)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.pas\\'" . fpc-mode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.pp\\'" . fpc-mode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.inc\\'" . fpc-mode))

(provide 'fpc-mode)

;;; fpc-mode.el ends here
