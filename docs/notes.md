[[http://wikemacs.org/wiki/Package.el#How_to_use_it_with_a_custom_build)]]

**Word Wrap**

Getting rid of visual-fill-column-mode, because I've just been using
the regular fill-paragraph command and it works well. Especially since
Markdown ignores the line breaks anyway. The only issue is
occasionally I need to remove the line breaks if someone else is going
to be editing a text file, but that's no big deal.

```
(defun my-word-wrap ()
  (visual-line-mode)
  (visual-fill-column-mode)
  )

(global-set-key (kbd "C-c 0")
                (lambda() (interactive) (my-word-wrap)))
```
