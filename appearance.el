;; goes in .emac.d/lisp/

(load-theme 'wombat t)

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
