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

;; Indentation

(setq-default indent-tabs-mode nil)

;; Auto-completion

(electric-pair-mode)

;; Appearance
(setq org-src-fontify-natively t) ;;So org-mode will syntax highlight src blocks
(require 'appearance)
(show-paren-mode)

;; Helm

(require 'my-helm)

;; Web Mode

(require 'my-web-mode)

;; sh-mode
;; (add-to-list 'auto-mode-alist '("\\.env\\'" . sh-mode))

;; Highlight Lines

(add-hook 'web-mode-hook 'hl-line-mode 1)
(setq global-hl-line-mode t)

(put 'upcase-region 'disabled nil)

(defun my-word-wrap ()
  (visual-line-mode)
  (visual-fill-column-mode)
  )

(global-set-key (kbd "C-c 0")
                (lambda() (interactive) (my-word-wrap)))

(global-set-key (kbd "C-c d") 'org-toggle-link-display)
(global-set-key (kbd "C-c u") 'insert-char)


(setq gofmt-command "goimports")
(require 'go-mode-autoloads)
(add-hook 'before-save-hook 'gofmt-before-save)

(setq browse-url-browser-function 'eww-browse-url)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("a4a164e4ff49554df4e725a987a8bac51c7c073b4affa4d2097295f4af690e3d" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(magit-diff-use-overlays nil)
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c37300")
     (60 . "#b97d00")
     (80 . "#b58900")
     (100 . "#a18700")
     (120 . "#9b8700")
     (140 . "#948700")
     (160 . "#8d8700")
     (180 . "#859900")
     (200 . "#5a942c")
     (220 . "#439b43")
     (240 . "#2da159")
     (260 . "#16a870")
     (280 . "#2aa198")
     (300 . "#009fa7")
     (320 . "#0097b7")
     (340 . "#008fc7")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
