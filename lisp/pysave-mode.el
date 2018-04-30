(define-minor-mode pysave-mode
  "Auto format and lint Python code on save."
  :lighter " pysave"
  (if pysave-mode
      (progn
        (add-hook 'before-save-hook 'elpy-format-code nil 'local)
        ;;(add-hook 'after-save-hook 'elpy-check nil 'local))
    (progn
      (remove-hook 'before-save-hook 'elpy-check 'local)
      ;;(remove-hook 'after-save-hook 'elpy-check 'local))
      )))
  )

(provide 'pysave-mode)
