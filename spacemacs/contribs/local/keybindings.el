(define-key evil-insert-state-map (kbd "C-h") 'left-char)
(define-key evil-insert-state-map (kbd "C-j") 'next-line)
(define-key evil-insert-state-map (kbd "C-k") 'previous-line)
(define-key evil-insert-state-map (kbd "C-l") 'right-char)
(define-key evil-insert-state-map (kbd "C-d") 'evil-delete-char)

(global-set-key (kbd "C-M-s-h") 'windmove-left)
(global-set-key (kbd "C-M-s-j") 'windmove-down)
(global-set-key (kbd "C-M-s-k") 'windmove-up)
(global-set-key (kbd "C-M-s-l") 'windmove-right)

(global-set-key (kbd "C-M-s-s") 'split-window-right-and-focus)
(global-set-key (kbd "C-M-s-v") 'split-window-below-and-focus)
(global-set-key (kbd "C-M-s-w") 'delete-window)

(global-set-key (kbd "s-w") 'delete-frame)
(global-set-key (kbd "C-M-s-:") 'eshell)
