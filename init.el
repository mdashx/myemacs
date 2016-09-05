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

;; (require 'my-web-mode)

;; Highlight Lines
;; (add-hook 'web-mode-hook 'hl-line-mode 1)

(put 'upcase-region 'disabled nil)

(add-hook 'before-save-hook 'gofmt-before-save)
(global-auto-revert-mode t)
;; (require 'ignore-modification-time)


