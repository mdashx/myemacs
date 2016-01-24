;; Startup
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Load Path
(let ((default-directory "~/.emacs.d/lisp"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Package Archives
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; Indentation
(setq-default indent-tabs-mode nil)

;; Auto-completion
(electric-pair-mode)
(show-paren-mode)

;; Helm
(require 'my-helm)

;; Web Mode
(require 'my-web-mode)
