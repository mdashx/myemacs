;; Goes in .emacs.d/lisp/

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  ;; (setq web-mode-enable-engine-detection t)

  (if (equal web-mode-content-type "javascript")
  (web-mode-set-content-type "jsx")
  (message "now set to: %s" web-mode-content-type))
  
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . t))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))

  ;; http://cha1tanya.com/2015/06/20/configuring-web-mode-with-jsx.html
  ;; Use JSX content for all JavaScript files
  (if (equal web-mode-content-type "javascript")
      (web-mode-set-content-type "jsx"))
  )





;; If you wan’t to force autoclosing, autopairing even in a terminal, add (setq web-mode-enable-auto-closing t) and (setq web-mode-enable-auto-pairing t) in your .emacs 

(setq web-mode-enable-auto-closing t)

(add-hook 'web-mode-hook  'my-web-mode-hook)

(provide 'my-web-mode)

