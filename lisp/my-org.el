(setq org-todo-keywords
       '((sequence "TODO(t)" "|" "DONE(d)" "CANCELED(c)")))

(setq org-agenda-files (list "~/work/notes/calendar.org" "~/work/notes/notes.org" "~/work/notes/work.org"))

(setq org-default-notes-file "~/work/notes/notes.org")

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 10))))

;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(provide 'my-org)
