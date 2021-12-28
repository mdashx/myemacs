(require 'package)
(require 'cl-lib)

;; Startup
(setq inhibit-startup-message t)


(defvar my-packages
  '(
    powerline
    ;; company
    ;; counsel
    ;; ivy
    ;; swiper
    ;; helm-core
    ;; helm

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

;; Aesthetics
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))
(menu-bar-mode -1)

(load-theme 'wombat t)
(powerline-default-theme)
