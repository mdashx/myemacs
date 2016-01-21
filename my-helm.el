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

(provide 'my-helm)
