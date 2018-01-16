;; Startup
(setq inhibit-startup-message t)

;; (if (display-graphic-p)
;;     (progn
;;       (tool-bar-mode -1)
;;       (scroll-bar-mode -1)))

(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))
(menu-bar-mode -1)

;; Load Path
(let ((default-directory "~/.emacs.d/lisp"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Backup Path
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Install Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(require 'my-packages)
;; (require 'go-guru)

(require 'rot47)

(defun rot13-replace-buffer ()
  (interactive)
  (let ((oldbuf (current-buffer)))
    (with-current-buffer (get-buffer-create "*rot-replace*")
      (erase-buffer)
      (insert-buffer-substring oldbuf)
      (let ((bufstr (buffer-string)))
        (erase-buffer)
        (insert (rot13 bufstr)))))
  (erase-buffer)
  (insert-buffer-substring "*rot-replace*"))


;; Global modes
;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; ^^ to annoying...

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Auto-completion
(electric-pair-mode)
(show-paren-mode)

;; Appearance
(setq org-src-fontify-natively t) ;;So org-mode will syntax highlight src blocks
(require 'appearance)
(show-paren-mode)

;; Mode-specific customizations
(require 'my-helm)

(require 'my-web-mode)

(require 'my-org)

(add-hook 'python-mode-hook 'anaconda-mode)

;; Highlight Lines
;; (add-hook 'web-mode-hook 'hl-line-mode 1)
;; (global-hl-line-mode) ;; hl color isn't correct when I load global-hl-line-mode at startup
(global-set-key (kbd "C-c g") 'global-hl-line-mode)

;; Company Autocompletion
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-\\") 'company-complete)
(setq company-dabbrev-downcase nil)

(put 'upcase-region 'disabled nil)

;; (setq gofmt-command "goimports")

;; should only add hook in go-mode
;; (add-hook 'before-save-hook 'gofmt-before-save)

(global-auto-revert-mode)
(setq auto-revert-use-notify nil)

;; (require 'ignore-modification-time)

(global-set-key (kbd "C-x g") 'magit-status)

;; The command to toggle ROT13 doesn't take effect until after I type
;; any other key after the key sequence. I'll figure that out... I'm
;; going to be adding my own ROT47 function anyway.
(define-prefix-command 'toms-map)
(define-key toms-map (kbd "e") 'toggle-rot13-mode)
(global-set-key (kbd "C-q") toms-map)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0be964eabe93f09be5a943679ced8d98e08fe7a92b01bf24478e56eee7b6b21d" "6254372d3ffe543979f21c4a4179cd819b808e5dd0f1787e2a2a647f5759c1d1" default)))
 '(fci-rule-color "#3E4451")
 '(package-selected-packages
   (quote
    (fireplace package-build shut-up epl git commander f dash s cask cask-mode yasnippet yasnippet-snippets minesweeper git-gutter magit flow-minor-mode flycheck flycheck-flow prettier-js lua-mode go-guru go-mode atom-dark-theme atom-one-dark-theme traad markdown-mode nginx-mode yaml-mode web-mode company helm helm-core powerline color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'downcase-region 'disabled nil)
