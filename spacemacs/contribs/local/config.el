(setq eshell-banner-message "")

(setq eshell-prompt-function
      (lambda ()
        (concat
         (propertize (eshell/pwd) 'face `(:foreground "#0087ff"))
         (propertize "\nε" 'face `(:foreground "white"))
         (propertize " : " 'face `(:foreground "grey")))))

(setq eshell-highlight-prompt nil)

;; Set prompt regexp so eshell can exit.
;; This is necessary since our prompt has a newline.
(setq eshell-prompt-regexp "^[^#$\n]*[ε] : ")
