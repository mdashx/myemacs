
;; Startup
(setq inhibit-startup-message t)

;; TODO
;; function interleave lines
;; Example...
;; Pair up these lines
;; /float-control-valves/no-51/
;; /float-control-valves/no-52/
;; /float-control-valves/no-53/
;; /float-control-valves/no-59/
;; No. 51 Water-Boy Float Control Valve
;; No. 52 Water-Boy Float Control Valve
;; No. 53 Water-Boy Float Control Valve
;; No. 59 Water-Boy Float Control Valve

;; https://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer
;; Elisp fn to replace " with '
;; elisp fn to kill all buffers except messages and scratch
;; shortcut key to open init file


;; (if (display-graphic-p)
;;     (progn
;;       (tool-bar-mode -1)
;;       (scroll-bar-mode -1)))

(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))
(menu-bar-mode -1)

;; On mac
;; (when (eq system-type 'darwin)
;;   (setq ns-pop-up-frames nil)
;;   (setq mac-command-modifier 'control))

;; Load Path
(let ((default-directory "~/.emacs.d/lisp"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Backup Path

(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)

;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))

;; (setq backup-directory-alist
;;           `(("." . ,"$HOME/.emacs-backups")))

;; (package-initialize)

(add-hook 'markdown-mode 'turn-on-auto-fill)

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
    (defun unfill-paragraph (&optional region)
      "Takes a multi-line paragraph and makes it into a single line of text."
      (interactive (progn (barf-if-buffer-read-only) '(t)))
      (let ((fill-column (point-max))
            ;; This would override `fill-column' if it's an integer.
            (emacs-lisp-docstring-fill-column t))
        (fill-paragraph nil region)))

(defun tch-join-lines ()
  "Re-join autofilled lines"
  (interactive)
  (set-fill-column 2000)
  (mark-whole-buffer)
  (fill-paragraph)
  ;; (set-fill-column 70)
  )

;; Install Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)


(require 'my-packages)
;; (require 'go-guru)

(require 'clang-format)
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)

;; (setq clang-format-style-option "llvm")

(defun clang-format-on-save ()
  "Format C cod on save."
  (add-hook 'before-save-hook 'clang-format-buffer nil 'local))

(add-hook 'c-mode-hook 'clang-format-on-save)

(global-flycheck-mode)






;; https://github.com/abo-abo/hydra/wiki/Emacs#hideshow-mode-for-code-folding
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

(global-unset-key "\C-j")

(require 'bind-key)

(bind-keys* :prefix-map my-prefix-map
            :prefix "C-j"
            ("j" . avy-goto-char)
            ("s" . swiper)
            ("l" . markdown-follow-link-at-point)
            ("n" . display-line-numbers-mode)
            ("f" . hydra-folding/body))


(bind-key* "C-M-\\" 'indent-rigidly-right)

(bind-key* "C-x i" 'avy-goto-line)

;; Todo - create Hydra for navigating parenthesis


(global-unset-key "\C-z") ;; Because I hate accidentally suspending Emacs

;; https://oremacs.com/swiper/#getting-started
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'hs-minor-mode)

(global-set-key (kbd "C-s") 'search-forward)
;; (global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(global-set-key (kbd "C-\\") 'backward-kill-word)

(require 'which-key)
(which-key-mode)

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


(global-set-key (kbd "C-c r") 'rot47-replace-buffer)


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
;; (require 'my-helm)

(require 'my-web-mode)

(require 'my-org)

;; Highlight Lines
;; (add-hook 'web-mode-hook 'hl-line-mode 1)
;; (global-hl-line-mode) ;; hl color isn't correct when I load global-hl-line-mode at startup
(global-set-key (kbd "C-c g") 'global-hl-line-mode)

;; Company Autocompletion
(add-hook 'after-init-hook 'global-company-mode)
;; (global-set-key (kbd "C-\\") 'company-complete) - just use M-C-i
(setq company-dabbrev-downcase nil)
(put 'upcase-region 'disabled nil)

(require 'company)

(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)


;; https://www.emacswiki.org/emacs/CompanyMode#toc7
;; Change the company mode colors
(require 'color)

(let ((bg (face-attribute 'default :background)))
  (custom-set-faces
   `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
   `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
   `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
   `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
   `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))


;; https://github.com/jorgenschaefer/elpy/issues/1084
;; Elpy doesn't work with Ivy
;; (elpy-enable)

;; (require 'pysave-mode)
;; (add-hook 'python-mode-hook 'pysave-mode)

(add-hook 'python-mode-hook 'blacken-mode)

(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'tex-mode-hook 'turn-on-auto-fill)

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

;; (global-set-key (kbd "C-q") toms-map)


(defun csv-to-strings ()
  "One way to add quotes to CSV items."
  (interactive)
  (search-forward ",")
  (backward-char 1)
  (insert "'")
  (forward-char 1)
  (insert "'")
  )

;; https://www.emacswiki.org/emacs/DosToUnix
(defun dos2unix (buffer)
  "Automate M-% C-q C-m RET C-q C-j RET"
  (interactive "*b")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward (string ?\C-m) nil t)
      ;; (replace-match (string ?\C-j) nil t))))
      (replace-match "" nil t))))


;; https://superuser.com/questions/603421/how-to-remove-smart-quotes-in-copy-pasteg
(defun replace-smart-quotes (beg end)
  "Replace 'smart quotes' in buffer or region with ascii quotes."
  (interactive "r")
  (format-replace-strings '(("\x201C" . "\"")
                            ("\x201D" . "\"")
                            ("\x2018" . "'")
                            ("\x2019" . "'"))
                          nil beg end))

(require 'yasnippet)
(yas-global-mode 1)

(setq scss-compile-at-save nil)

(add-hook 'haskell-mode-hook 'flycheck-mode)
(add-hook 'haskell-mode-hook 'dante-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(auto-save-interval 0)
 '(auto-save-timeout 86400)
 '(custom-safe-themes
   '("0be964eabe93f09be5a943679ced8d98e08fe7a92b01bf24478e56eee7b6b21d" "6254372d3ffe543979f21c4a4179cd819b808e5dd0f1787e2a2a647f5759c1d1" default))
 '(fci-rule-color "#3E4451")
 '(package-selected-packages
   '(haskell-mode sass-mode scss-mode ledger-mode vue-mode visual-fill-column clang-format elm-mode blacken vlf lispy paredit projectile golden-ratio treemacs bind-key hydra avy key-seq key-chord which-key evil-tutor evil rainbow-delimiters rainbow-mode noctilux-theme fireplace package-build shut-up epl git commander f dash s cask cask-mode yasnippet yasnippet-snippets minesweeper git-gutter magit flycheck flycheck-flow prettier-js lua-mode go-guru go-mode atom-dark-theme atom-one-dark-theme traad markdown-mode nginx-mode yaml-mode web-mode company helm helm-core powerline color-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#199919991999"))))
 '(company-scrollbar-fg ((t (:background "#0ccc0ccc0ccc"))))
 '(company-tooltip ((t (:inherit default :background "#051e051e051e"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face)))))

(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)



