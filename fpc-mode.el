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
    "inline" "interface" "label" "mod" "nil" "not" "object" "of"
    "on" "operator" "or" "packed" "procedure" "program" "record" "reintroduce"
    "repeat" "self" "set" "shl" "shr" "string" "then" "to"
    "type" "unit" "until" "uses" "var" "while" "with" "xor"

    ;; Delphi
    "as" "class" "except" "exports" "finalization" "finally" "initialization"
    "is" "library" "on" "property" "raise" "threadvar" "try"

    ;; Free Pascal
    "dispose" "exit" "false" "new" "true" "break" "continue"))


(defconst fpc-font-lock-keywords
  (list
   `(,(regexp-opt fpc-keywords 'symbols) . font-lock-keyword-face)
   `("\\_<\\(function\\|pro\\(cedure\\|gram\\)\\)[ \t]+\\([[:alpha:]][[:alnum:]_]*\\)"
     (3 font-lock-function-name-face))))

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
