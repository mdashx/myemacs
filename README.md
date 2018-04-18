## TODO:

LOCALE LANG need to be unicode

`update-locale LANG=en_US.utf8`
https://help.ubuntu.com/community/Locale

Upgraded to Emacs 25 on MacOS and the config works fine now on both Linux and Mac.

* Try to figure out what I've added and removed from .emacs that I don't want to miss - msg here
* Automate package installation -- msg here

Should all hooks go on in one place, and then their specific actions in a different file? Then it'd be easy to see all of the hooks and keybindings I've defined, but I can define the function they call somewhere else.

* ~~How do other Emacs setups handling the load path?~~ -- msg here
* ~~Replace Ido with Helm~~
* ~~Get powerline glyphs in terminal?~~ -- msg here
* Do a better job of setting up autocompletion
* ~~Why does my Ctrl-C 0 shortcut to toggle linewrap sometimes crash Emacs in the terminal?~~ -- msg here
* Define header templates for different types of source code files - use git config vars?
* Check environment vars to see if in terminal or in OSX -- msg here
* Setup different Python modes based on env
* Setup GUI stuff based on env? -- msg here
* Add keybinding for org-store-link
* Setup bookmarks file to open on start -- msg here
* ~~Split window on start so visual-fill-column doesn't crash: https://github.com/joostkremers/visual-fill-column/issues/1#issuecomment-198032933~~
* ~~Global highlight line mode~~ -- msg here


## MORE TODOS:
- Visualize indent levels
- Fold long YAML (and other format) files, fold blocks in any language
- Hook up flyspell, auto-fill-mode, etc. for txt, md, and org modes
- Magit exercises
- Get Python linting hooked up again
- Show git/diff gutters
