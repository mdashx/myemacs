(load-theme 'wombat t)
(powerline-default-theme)

;; http://stackoverflow.com/questions/18210631/how-to-change-the-character-composing-the-emacs-vertical-border
;; Reverse colors for the border to have nicer line
(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))

;; Set symbol for the border
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))

;; thinner border -> │
;; thicker border -> ┃

;; http://emacs.stackexchange.com/questions/9740/how-to-define-a-good-highlight-face
;; http://stackoverflow.com/questions/17701576/changing-highlight-line-color-in-emacs
(require'color)

(defun set-hl-line-color-based-on-theme ()
  "Sets the hl-line face to have no foregorund and a background
    that is 2% darker than the default face's background."
  (set-face-attribute 'hl-line nil
                      :underline nil
                      :foreground nil
                      :background (color-darken-name (face-background 'default) 2))
  )

(defun keep-syntax-highlighting ()
  (interactive)
  (set-face-foreground 'highlight nil))

(add-hook 'hl-line-mode-hook 'set-hl-line-color-based-on-theme)
(add-hook 'hl-line-mode-hook 'keep-syntax-highlighting)

(add-hook 'global-hl-line-mode-hook 'set-hl-line-color-based-on-theme)
(add-hook 'global-hl-line-mode-hook 'keep-syntax-highlighting)

(provide 'appearance)
