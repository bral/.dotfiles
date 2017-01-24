(defun js-set-indent (indent)
  (progn
    (setq js-indent-level indent)
    (setq js2-basic-offset indent)
    (setq json-reformat:indent-width indent)))

(defun js-toggle-indent ()
  (if (equal js2-basic-offset 2)
      (js-set-indent 4)
    (js-set-indent 2)))
