(require 'package)
(require 'cl-lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar my-packages
  '(
    avy
    blacken
    company
    counsel ;; this also installs ivy and swiper as dependencies
    diff-hl
    flycheck
    hydra
    lsp-jedi
    lsp-mode
    plantuml-mode
    powerline
    prettier-js
    projectile
    python-isort
    rainbow-delimiters
    use-package
    visual-fill-column
    web-mode
    which-key
    )
  )

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(defun my-packages-installed-p ()
  (cl-loop for p in my-packages
        when (not (package-installed-p p)) do (cl-return nil)
        finally (cl-return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Aesthetics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-startup-message t)
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))
(menu-bar-mode -1)

(load-theme 'wombat t)
(powerline-default-theme)

;; Open Magnifier with Win key + "+" key, Ctrl + Alt + L for "lens"
;; mode, Win + esc to close
;; (set-face-attribute 'default nil :font "Inconsolata-16")
(set-face-attribute 'default nil :font "Inconsolata-12")





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Usability
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Auto-revert

(global-auto-revert-mode)

;; I hate the annoying backup files...
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)

;; And I hate the annoying bell
(setq ring-bell-function 'ignore)

(require 'color)

(defun set-hl-line-color-based-on-theme ()
  "Sets the hl-line face to have no foregorund and a background
    that is 2% darker than the default face's background."
  (set-face-attribute 'hl-line nil
                      :underline nil
                      :foreground nil
                      :background (color-darken-name
                                   (face-background 'default) 2)))


(defun keep-syntax-highlighting ()
  (interactive)
  (set-face-foreground 'highlight nil))

(add-hook 'global-hl-line-mode-hook 'set-hl-line-color-based-on-theme)
(add-hook 'global-hl-line-mode-hook 'keep-syntax-highlighting)

(global-diff-hl-mode)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Programming modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'lsp-mode)
(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(electric-pair-mode)
(show-paren-mode)
(projectile-mode 1)
(global-flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; My keybindings

(with-eval-after-load 'org
  (define-key org-mode-map [(control j)] nil))

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(defhydra hydra-folding ()
  "
Hide^^            ^Show^            ^Toggle^    ^Navigation^
----------------------------------------------------------------
_h_ hide all      _s_ show all      _t_oggle    _n_ext line
_d_ hide block    _a_ show block              _p_revious line
_l_ hide level

_SPC_ cancel
"
   ("s" hs-show-all)
   ("h" hs-hide-all)
   ("a" hs-show-block)
   ("d" hs-hide-block)
   ("t" hs-toggle-hiding)
   ("l" hs-hide-level)
   ("n" forward-line)
   ("p" (forward-line -1))
   ("SPC" nil)
)

(defhydra hydra-show-lines ()
   ("s" (global-display-line-numbers-mode 1))
   ("h" (global-display-line-numbers-mode -1))
   ("a" (global-hl-line-mode 1))
   ("d" (global-hl-line-mode -1))
  )

(defhydra hydra-base (global-map "C-j")
  "
Options^^
---------
_f_ folding  
_s_ search

_SPC_ cancel
"
  ("f" hydra-folding/body :exit t)
  ("j" avy-goto-char :exit t)
  ("n" hydra-show-lines/body :exit t)
  ("s" swiper :exit t)
  ("SPC" nil)
  )

(global-display-line-numbers-mode)

;; Overriding defaults with my preferred tools
(global-set-key (kbd "C-s") 'search-forward)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x b") 'counsel-switch-buffer)
(global-unset-key "\C-z") ;; Because I hate accidentally suspending Emacs

;; (setq lsp-keymap-prefix "s-l")
;; (global-set-key (kbd "C-c l") lsp-command-map)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; https://oremacs.com/swiper/#getting-started
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(require 'which-key)
(which-key-mode)

(require 'company)
(global-company-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-mode / text-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-agenda-files '("~/notes"))
(setq org-icalendar-timezone "America/Costa_Rica")

(add-hook 'text-mode-hook (lambda() (visual-line-mode 1)))
(add-hook 'org-mode-hook (lambda() (visual-line-mode 1)))
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-hook 'python-mode-hook 'blacken-mode)
;; (add-hook 'python-mode-hook 'python-isort-on-save-mode)
(add-hook 'python-mode-hook 'lsp)

(use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JavaScript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))

(defvar mmm-submode-decoration-level 0)
(defvar js-indent-level 2)

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-concats" . t))
(add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))

;; (setq web-mode-script-padding 0)

;; https://emacs.stackexchange.com/a/47415
;; http://cha1tanya.com/2015/06/20/configuring-web-mode-with-jsx.html
;; Use JSX content for all JavaScript files
;; (if (equal web-mode-content-type "javascript")
;;     (web-mode-set-content-type "jsx"))

(add-hook 'web-mode-hook
          (lambda ()
            ;; short circuit js mode and just do everything in jsx-mode
            (if (equal web-mode-content-type "javascript")
                (web-mode-set-content-type "jsx")
              (message "now set to: %s" web-mode-content-type))))

;; (setq web-mode-enable-auto-closing t)

(require 'prettier-js)
(add-hook 'web-mode-hook 'prettier-js-mode)

;; (setq prettier-js-args '(
;;   "--trailing-comma" "es5"
;;   "--single-quote" "false"
;; ))


;; Other modes
;; (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
;; (add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))

(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . text-mode))
(add-to-list 'auto-mode-alist '("\\.puml\\'" . text-mode))

;;(setq plantuml-default-exec-mode 'executable)

(setq plantuml-jar-path "/home/tom/bin/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)


;; (require 'org)
;; (define-key org-mode-map (kbd "<C-j>") nil)

;; (with-eval-after-load 'org
;;   (define-key org-mode-map "<C-j>" nil))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/notes/") t)
 '(package-selected-packages
   '(ttl-mode yasnippet which-key web-mode use-package rainbow-delimiters pyvenv python-isort pyenv-mode projectile prettier-js powerline plantuml-mode lsp-jedi hydra highlight-indentation flycheck diff-hl counsel company-anaconda blacken avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
