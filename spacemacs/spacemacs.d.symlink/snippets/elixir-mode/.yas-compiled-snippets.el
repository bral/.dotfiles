;;; Compiled snippets and support files for `elixir-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'elixir-mode
                     '(("pI" "|> (&(IO.inspect(${1:VALUE$(upcase yas-text)}: &1) && &1)).()" "inspect-pipe-kw" nil nil nil "/Users/michaelvanasse/.spacemacs.d/snippets/elixir-mode/inspect-pipe-kw" nil nil)
                       ("pi" "|> (&(IO.inspect(&1) && &1)).()" "inspect-pipe" nil nil nil "/Users/michaelvanasse/.spacemacs.d/snippets/elixir-mode/inspect-pipe" nil nil)
                       ("I" "IO.inspect([{:\"${1:$(upcase yas-text)}$2\", ${1:value}}])$0" "inspect-kw" nil nil nil "/Users/michaelvanasse/.spacemacs.d/snippets/elixir-mode/inspect-kw" nil nil)
                       ("i" "IO.inspect(${1:value})$0" "inspect" nil nil nil "/Users/michaelvanasse/.spacemacs.d/snippets/elixir-mode/inspect" nil nil)))


;;; Do not edit! File generated at Fri Sep  9 16:03:23 2016
