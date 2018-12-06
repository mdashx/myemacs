(load-theme 'wombat t)
;; (load-theme 'noctilux t)

;; https://github.com/jonathanchu/atom-one-dark-theme/issues/6
;; Customize background for terminal for atom one dark color
(if (not window-system)
    (defvar atom-one-dark-colors-alist
      '(("atom-one-dark-accent"   . "#528BFF")
        ("atom-one-dark-fg"       . "#ABB2BF")
        ("atom-one-dark-bg"       . "gray14")
        ("atom-one-dark-bg-1"     . "gray13")
        ("atom-one-dark-bg-hl"    . "gray13")
        ("atom-one-dark-gutter"   . "#666D7A")
        ("atom-one-dark-accent"   . "#AEB9F5")
        ("atom-one-dark-mono-1"   . "#ABB2BF")
        ("atom-one-dark-mono-2"   . "#828997")
        ("atom-one-dark-mono-3"   . "#5C6370")
        ("atom-one-dark-cyan"     . "#56B6C2")
        ("atom-one-dark-blue"     . "#61AFEF")
        ("atom-one-dark-purple"   . "#C678DD")
        ("atom-one-dark-green"    . "#98C379")
        ("atom-one-dark-red-1"    . "#E06C75")
        ("atom-one-dark-red-2"    . "#BE5046")
        ("atom-one-dark-orange-1" . "#D19A66")
        ("atom-one-dark-orange-2" . "#E5C07B")
        ("atom-one-dark-gray"     . "#3E4451")
        ("atom-one-dark-silver"   . "#AAAAAA")
        ("atom-one-dark-black"    . "#0F1011"))
      "List of Atom One Dark colors.")
  )

;; (load-theme 'atom-one-dark t)
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

;; (add-hook 'hl-line-mode-hook 'set-hl-line-color-based-on-theme)
(add-hook 'hl-line-mode-hook 'keep-syntax-highlighting)

;; (add-hook 'global-hl-line-mode-hook 'set-hl-line-color-based-on-theme)
(add-hook 'global-hl-line-mode-hook 'keep-syntax-highlighting)

;; (set-default-font "Ubuntu Mono:pixelsize=16")

(provide 'appearance)
