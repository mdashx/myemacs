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


...global-hl-line-mode doesn't use the custom higlight color when I
load it from init.el, but it does if I turn it off and load it once
Emacs is started.

...powerline is showing icons for missing glyphs, in my current Emacs
installation, the missing fonts are just blank, but now there is a [?]
icon.

OK - installed the powerline fonts: https://github.com/powerline/fonts
in OS X, and then in iTerm2, went into my profile and selected
Inconsolata for Powerline as my non-ASCII font, and now I have all
kinds of cool looking stuff in powerline, similar to in the GUI.


