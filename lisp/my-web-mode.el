;; Goes in .emacs.d/lisp/

(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.vue?\\'" . vue-mode))

(defvar mmm-submode-decoration-level 0)
(defvar js-indent-level 2)



(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  ;; (setq web-mode-enable-engine-detection t)

  ;; (if (equal web-mode-content-type "javascript")
  ;; (web-mode-set-content-type "jsx")
  ;; (message "now set to: %s" web-mode-content-type))
  
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . t))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))

  (setq web-mode-script-padding 0)
  ;; http://cha1tanya.com/2015/06/20/configuring-web-mode-with-jsx.html
  ;; Use JSX content for all JavaScript files
  (if (equal web-mode-content-type "javascript")
      (web-mode-set-content-type "jsx"))
  )

;; If you wan’t to force autoclosing, autopairing even in a terminal,
;; add (setq web-mode-enable-auto-closing t) and (setq
;; web-mode-enable-auto-pairing t) in your .emacs

(setq web-mode-enable-auto-closing t)

;; https://github.com/prettier/prettier-emacs
(require 'prettier-js)

(setq prettier-js-args '(
  "--trailing-comma" "es5"
  "--single-quote" "false"
))

;; (require 'flycheck-flow)
;; (require 'flow-minor-mode)

(setq flycheck-javascript-eslint-executable "eslint_d")

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair)))))

(add-hook 'web-mode-hook  'my-web-mode-hook)
;; (add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook #'(lambda ()
                            (enable-minor-mode
                             '("\\.jsx?\\'" . prettier-js-mode))))

(add-hook 'web-mode-hook #'(lambda ()
                            (enable-minor-mode
                             '("\\.vue?\\'" . prettier-js-mode))))


(add-hook 'web-mode-hook 'flycheck-mode)
;; (add-hook 'web-mode-hook 'flow-minor-mode)

;; (flycheck-add-next-checker 'javascript-flow 'javascript-flow-coverage)

;;(with-eval-after-load 'company
;;  (add-to-list 'company-backends 'company-flow))

;; (require 'prettier-js)
;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook 'prettier-before-save)))

(provide 'my-web-mode)

