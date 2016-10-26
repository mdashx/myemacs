;; Startup
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)

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

;; Indentation
(setq-default indent-tabs-mode nil)

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

;; Highlight Lines
;; (add-hook 'web-mode-hook 'hl-line-mode 1)
;; (global-hl-line-mode) ;; hl color isn't correct when I load global-hl-line-mode at startup
(global-set-key (kbd "C-c g") 'global-hl-line-mode)

;; Company Autocompletion
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-\\") 'company-complete)


(put 'upcase-region 'disabled nil)

(add-hook 'before-save-hook 'gofmt-before-save)
(global-auto-revert-mode)
(setq auto-revert-use-notify nil)

;; (require 'ignore-modification-time)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode nginx-mode yaml-mode web-mode company helm helm-core powerline color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
