;; Goes in .emacs.d/lisp/

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  ;; (setq web-mode-enable-engine-detection t)

  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . t))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
  )


;; If you wan’t to force autoclosing, autopairing even in a terminal, add (setq web-mode-enable-auto-closing t) and (setq web-mode-enable-auto-pairing t) in your .emacs 

(setq web-mode-enable-auto-closing t)

(add-hook 'web-mode-hook  'my-web-mode-hook)

(provide 'my-web-mode)

