(setq helm-split-window-in-side-p 1)
(require 'helm-config)
(helm-mode)

(add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.2)))

(setq helm-display-header-line nil)
(set-face-attribute 'helm-source-header nil :height 0.9)
(global-set-key (kbd "C-x b") 'helm-mini)
(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)

(provide 'my-helm)
