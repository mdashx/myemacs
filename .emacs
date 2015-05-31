
;; Enable command and option keys when in OS X
(setq mac-command-modifier 'control)
(setq mac-option-modifier 'meta)

;; http://www.emacswiki.org/emacs/AlarmBell#toc11
(defun my-terminal-visible-bell ()
   "A friendlier visual bell effect."
   (invert-face 'mode-line)
   (run-with-timer 0.1 nil 'invert-face 'mode-line))
 
 (setq visible-bell nil
       ring-bell-function 'my-terminal-visible-bell)

;; Load yasnippets-snippets
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets/"
	"~/.emacs.d/yasnippet-snippets/")
      )
(yas-global-mode 1)

