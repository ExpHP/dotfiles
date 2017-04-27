;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path
   '(
     ;; git submodule init && git submodule update
     "~/dotfiles/spacemacs/external/TheBB"
     )
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     markdown
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; suggestions contained in the original .spacemacs
     (auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence "jk"
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-enable-help-tooltip 'manual
                      )
     ;; better-defaults
     ;; spell-checking
     ;; syntax-checking
     ;; markdown

     ;; language layers; straightforward
     haskell
     javascript
     python
     latex
     idris
     rust
     emacs-lisp
     yaml
     org

     git ;; this adds explicit interaction with git
     version-control ;; this adds highlighting/gutter info

     helm

     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)

     ;; hides . and .. in helm-find-files; from TheBB's config layers.
     ;; (included via git submodule)
     no-dots
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(kakapo-mode flycheck flycheck-rust)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(lush
                         ;; alect-black
                         ;; sanityinc-tomorrow-bright
                         ;; grandshell
                         spacemacs-dark
                         ;; spacemacs-light
                         )
   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non-nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non-nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non-nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non-nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non-nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non-nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  (load "~/dotfiles/spacemacs/framegeometry")
  (setq framegeometry-path "~/dotfiles/spacemacs/var/framegeometry")
  (framegeometry-hatsudou!!)
  )

(defun dotspacemacs//haskell-toggle-qualified ()
  "toggle the qualified-ness of a single import in haskell"
  ;; TODO: sensible behavior when multiple lines are marked
  (interactive)
  (goto-char (line-beginning-position))
  (let ((from-qual   "import[[:space:]]+qualified[[:space:]]+")
        (from-unqual "import[[:space:]]+")
        (to-qual     "import qualified ")
        (to-unqual   "import           "))
    ;; (if it isn't an import line, don't do anything at all)
    (if (looking-at-p "import")

        (if (looking-at from-qual)
            (replace-match to-unqual)
          (looking-at from-unqual)
          (replace-match to-qual)))))

(defun dotspacemacs/retry-with-timer (time repeat function &rest args)
  "Do `run-at-time' repeatedly until the function returns non-nil,
up to some maximum number of times have been reached (or `nil' to keep
trying forever; notice this differs from `run-at-time')."
  (interactive)
  (unless (<= repeat 0)
    (unless (apply function args)
      (apply #'run-at-time time nil
             'dotspacemacs/retry-with-timer time (1- repeat) function args))))

(defun dotspacemacs/latex-try-open-errors ()
  " Attempt to open the latex error buffer, if it exists.
Returns t on success, nil on failure."
  (interactive)
  (if (get-process "LatexMk")
      nil ; still running
    (save-selected-window
      (TeX-error-overview)
      t)))

(defun dotspacemacs/latex-build ()
  "Build a latex file. Now with 98% less carpal tunnel.

I mean, *really*, 'C-c `'?
Are you trying to kill us?"

  (interactive)
  (latex/build)
  (dotspacemacs/retry-with-timer "1 sec" 10
                                 'dotspacemacs/latex-try-open-errors)
  )

(defun dotspacemacs/brazenly-replace-things ()
  "Now, this can't *possibly* go wrong."
  (interactive)
  (dolist (x '(("-="  "->")
               ("=-"  "<-")
               (";;"  "::")
               (",./" "=>")))
    (save-excursion (goto-char (point-min))
                    ;; (replace-string . x) ;;
                    (replace-string (car x) (cadr x)))))

;;=========================================
;;  This junk should be pulled out into a layer I guess?
;;
;;  But then, I'm not sure how to write a layer that doesn't depend on
;;  any packages. (all the init functions are e.g. init-SOME-PACKAGE)
;;
;;  So I guess I need to make a package too?
;;
;;  Eugh. Whatever.

(defun dotspacemacs/simulate-insert-char (val)
  "A target for a key binding which tries to simulate inserting the key in such
   a way that e.g. smartparens can intercept it, but without the possibility of
   being recursively invoked;  that makes this a suitable target to use when swapping
   two keys in a minor mode. (whereas keyboard macros would get in a recursion loop)
   "
    `(lambda ()
      (interactive)
      (insert ,val)
      (run-hooks 'post-self-insert-hook)
      ))

(defun dotspacemacs/char-swapping-keymap (a b)
  "Create a keymap that swaps keys in insert-state. A and B are strings;
   the first character of A is swapped with the first character of B."
  (apply 'append
         (cl-mapcar (lambda (x y)
                      `((,(kbd x) . ,(dotspacemacs/simulate-insert-char y))
                        (,(kbd y) . ,(dotspacemacs/simulate-insert-char x))
                        ))
                    (split-string a "" t)
                    (split-string b "" t))))

(define-minor-mode shifted-numbers-mode
  "Shifted Numbers mode (for US keyboard layout)"
  nil
  "#"
  (dotspacemacs/char-swapping-keymap "1234567890" "!@#$%^&*()")
  :global t)

(define-minor-mode unshifted-braces-mode
  "Shifted Brackets mode (for US keyboard layout)"
  nil
  "{"
  (dotspacemacs/char-swapping-keymap "[]" "{}")
  :global t)

(define-minor-mode unshifted-underscore-mode
  "Unshifted Underscore mode (for US keyboard layout)"
  nil
  "_"
  (dotspacemacs/char-swapping-keymap "-" "_")
  :global t)

(define-minor-mode unshifted-plus-mode
  "Unshifted Plus mode (for US keyboard layout)"
  nil
  "+"
  (dotspacemacs/char-swapping-keymap "=" "+")
  :global t)

(define-minor-mode unshifted-quotes-mode
  "Unshifted Quotes mode (for US keyboard layout)"
  nil
  "\""
  (dotspacemacs/char-swapping-keymap "'" "\"")
  :global t)

(define-minor-mode unshifted-colon-mode
  "Unshifted Colon mode (for US keyboard layout)"
  nil
  ":"
  (dotspacemacs/char-swapping-keymap ";" ":")
  :global t)

(define-minor-mode unshifted-pipe-mode
  "Unshifted Pipe mode (for US keyboard layout)"
  nil
  "|"
  (dotspacemacs/char-swapping-keymap "\\" "|")
  :global t)

;; misnamed, but who wants unshifted-angle-mode?
(define-minor-mode unshifted-angle-mode
  "Unshifted Angle mode (for US keyboard layout)"
  nil
  "<"
  (dotspacemacs/char-swapping-keymap ",." "<>")
  :global t)

;;=========================================

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; work around nasty interface-locking bugs in evil's forward-slash search.
  ;; https://github.com/syl20bnr/spacemacs/issues/3623#issuecomment-284534269
  (setq-default search-invisible t)

  ;; kakapo-mode: Indent with tabs OR spaces; align with spaces.
  (load "~/dotfiles/spacemacs/kakapo-settings")
  (require 'kakapo-mode)
  ;; Some elaborate mode-specific settings are in the settings file
  (kakapoconf-global-init)

  ;; Bothersome question when editing a symlinked file whose target is under source control.
  (setq vc-follow-symlinks nil)

  (setq rust-indent-offset 4)

  ;; Old habits die hard.  Accidentally quitting emacs sucks.
  (evil-ex-define-cmd "q[uit]" nil)
  (evil-ex-define-cmd "wq" nil)

  (setq personal-abbrev-file-name "~/dotfiles/spacemacs/abbrev_defs")
  (setq abbrev-file-name personal-abbrev-file-name)
  (dolist (x '((haskell-mode . haskell-mode-hook))
             (with-eval-after-load (car x)
               (add-hook (cdr x)
                         ;; electric-indent-mode insidiously replaces the abbrevs file!
                         ;; ...I think?
                         (lambda ()
                           (electric-indent-mode 0)
                           (abbrev-mode) ; this doesn't seem to actually
                                         ; enable it.  Docs say to supply a
                                         ; positive argument in interactive
                                         ; use, and nil in noninteractive use.
                           (read-abbrev-file personal-abbrev-file-name))))))

  (with-eval-after-load 'rust-mode
    (setq cargo-process--custom-path-to-bin "/usr/bin"))

  (with-eval-after-load 'helm
    (setq helm-ff-skip-boring-files t)
    (dolist (x '("\\.hi$"))
      (add-to-list 'helm-boring-file-regexp-list x)))

  ;; 80 kilobytes? C'mon! 80 MEGABYTES!
  (setq undo-limit 80000000)
  (setq undo-strong-limit 120000000)

  (setq scroll-margin 10)

  ;; bypass the transient mode on these because I use them to initiate
  ;; search-and-replace ("*ciWstring<CR>n.n.n.n.n.n.")
  (evil-global-set-key 'normal "*" 'evil-search-word-forward)
  (evil-global-set-key 'normal "#" 'evil-search-word-backward)

  ;; custom evil-lisp-state keybinds
  ;; NOTE: (this works because SPC k and lisp-state share the same keymap)
  (spacemacs/set-leader-keys
    ;; these help clean up small formatting issues that can arise in lisp-state...
    "k x" 'sp-delete-char ;; for the occasional extra space at the cursor...
    "k =" 'evil-indent    ;; for when something doesn't use sp-newline

    ;; preventative measures
    "k C-j" 'sp-newline

    ;; I've always felt that vim's j and k should have been flipped.
    ;; I've long since gotten used to it in normal typing,
    ;; but in lisp-state it somehow *still* feels absurd!
    "k k" 'evil-lisp-state-next-closing-paren
    "k j" 'evil-lisp-state-prev-opening-paren
    )

  (spacemacs/set-leader-keys
    "t 1"  'shifted-numbers-mode
    "t ["  'unshifted-braces-mode
    "t ]"  'unshifted-braces-mode
    "t -"  'unshifted-underscore-mode
    "t ="  'unshifted-plus-mode
    "t '"  'unshifted-quotes-mode
    "t ;"  'unshifted-colon-mode
    "t \\" 'unshifted-pipe-mode
    "t ,"  'unshifted-angle-mode
    "t ."  'unshifted-angle-mode
    )

  (spacemacs/set-leader-keys
    "d f"  'flycheck-mode
    )

  ;; make private/snippets/fundamental-mode work in fundamental-mode
  ;; (FIXME: ummmm... these snippets still aren't working...)
  (add-hook 'yas-minor-mode-hook
            (lambda ()
              (yas-activate-extra-mode 'fundamental-mode)))

  (add-to-list 'spacemacs-indent-sensitive-modes 'idris-mode)
  (with-eval-after-load 'idris-mode
    (setq idris-enable-elab-prover t)
    (setq idris-stay-in-current-window-on-compiler-error t)

    ;; https://github.com/syl20bnr/spacemacs/issues/8354#issuecomment-279620030
    (dolist (x '("*idris-notes*" "*idris-holes*" "*idris-info*"))
      (plist-put (cdr (assoc x popwin:special-display-config)) :noselect t))

    )

  (push '("*TeX errors*" :position bottom :height 8 :noselect t :dedicated t)
    popwin:special-display-config)

  (with-eval-after-load 'neotree
    (setq neo-window-fixed-size nil))

  (with-eval-after-load 'haskell-mode
    (add-hook 'haskell-mode-hook
              (lambda ()
                (add-hook 'before-save-hook
                          'dotspacemacs/brazenly-replace-things
                          nil t))))

  (with-eval-after-load 'haskell-mode
    (spacemacs/declare-prefix-for-mode 'haskell-mode "mi" "haskell/intero")
    (spacemacs/set-leader-keys-for-major-mode 'haskell-mode
      "ii" 'intero-mode
      "ir" 'intero-restart
      "it" 'intero-targets
      "dq" 'dotspacemacs//haskell-toggle-qualified
      ))

  ;; NOTE: additional settings for haskell-mode in kakapo-settings
  (add-to-list 'spacemacs-indent-sensitive-modes 'haskell-mode)
  (with-eval-after-load 'haskell-interactive-mode
    (setq haskell-process-log t))

  (with-eval-after-load 'haskell-mode
    (setq haskell-process-suggest-remove-import-lines nil))

  ;;------------------------------
  ;; NOTE: general advice on intero + stack:

  ;; * for local-filesystem deps:
  ;;
  ;;   1. You must have an entry under 'packages' in stack.yaml:
  ;;
  ;;           packages:
  ;;           - location: path/to/package
  ;;             extra-dep: true
  ;;
  ;;      without "extra-dep: true" you will get hidden-package errors everywhere
  ;;      (the repl won't load them properly until you trick it into doing
  ;;       "-package name", and for intero you'll be forced to open 'M-x intero-targets')
  ;;
  ;;      NOTE: I've only tried this with deps symlinked into a location inside
  ;;      the current dir.  I don't know if you can use absolute paths.
  ;;
  ;;   2. Make sure there aren't two 'packages' lists (I've... made this mistake)
  ;;
  ;;   3. You don't need to list them in the "extra-deps" list in stack.yaml
  ;;
  ;;   4. You DO need to depend on them in *.cabal
  ;;
  ;;   5. Once deps are added to *.cabal, do a 'stack build'. (You will see
  ;;      them get installed)
  ;;
  ;;   6. That should be it...?  (do 'M-x intero-restart' if it is active)

  ;; * Typically, when intero-mode is started on a module in a test suite,
  ;;   it will refuse to acknowledge the existence of any imported modules
  ;;   from inside the test suite or its dependencies.
  ;;   (the "module X is not part of any known package" sort of error
  ;;    that occurs on import statements)
  ;;
  ;;   To fix, you should do two things:
  ;;
  ;;      1. (to fix dependencies)  Pop into a console and do "stack test".
  ;;         You will see it download anything recently added to the build-depends
  ;;         of the test suite.
  ;;
  ;;      2. (to fix intero) do "M-x intero-targets" and select all you see.
  ;;         The test suite should be on that list.
  ;;         You generally need to do this after each time you start "intero-mode".

  ;; * Sometimes it may be observed that intero only reports errors on
  ;;   import lines; once these are correct it reports the rest of the
  ;;   file to have no errors, despite very clear mistakes.
  ;;
  ;;   When this occurs, an error is most likely occuring in another file.
  ;;   Go visit any modules you import that are a part of your codebase.

  ;; NOTE: Things that are still brooken and I'm not sure how to fix:

  ;; * I keep seeing company provide completions inside comments/strings,
  ;;   and nowhere else.  (i.e. exactly the set of locations where you
  ;;   would NOT want completions)
  ;;------------------------------

  (with-eval-after-load 'org-mode
    ;; a.k.a line-wrap
    (spacemacs/toggle-visual-line-navigation-on))

  (with-eval-after-load 'ox
    ;; Enabling this is necessary to use #+BIND: flags in org files, which modify variables.
    ;; Unlike the "Local Voldemorts:" functionality of emacs, there is no prompt,
    ;;  so I feel uncomfortable leaving it on.
    (setq org-export-allow-bind-keywords nil))

  (with-eval-after-load 'tex
    (spacemacs/set-leader-keys-for-major-mode 'latex-mode
      "b" 'dotspacemacs/latex-build
      )

    ;(evil-define-key 'insert LaTeX-mode-map (kbd "C-9") "\(")
    ;(evil-define-key 'insert LaTeX-mode-map (kbd "C-0") "\)")
    )
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-compile-cabal-build-command "cd %s && cabal new-build --ghc-option=-ferror-spans")
 '(package-selected-packages
   (quote
    (company-quickhelp pos-tip helm-company helm-c-yasnippet fuzzy company-tern dash-functional tern company-statistics company-cabal company-auctex company-anaconda auto-yasnippet ac-ispell auto-complete mmm-mode markdown-toc markdown-mode gh-md winum toml-mode racer cargo rust-mode auctex-latexmk yapfify yaml-mode xterm-color ws-butler window-numbering which-key web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spacemacs-theme spaceline smeargle shell-pop restart-emacs rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree multi-term move-text magit-gitflow macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint kakapo-mode json-mode js2-refactor js-doc intero info+ indent-guide idris-mode ido-vertical-mode hy-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-ag haskell-snippets google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help elisp-slime-nav dumb-jump diff-hl define-word cython-mode company-ghci company-ghc column-enforce-mode coffee-mode cmm-mode clean-aindent-mode auto-highlight-symbol auto-compile auctex anaconda-mode aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line)))
 '(safe-local-variable-values
   (quote
    ((idris-load-packages "pruviloj")
     (idris-load-packages list "pruviloj")
     (idris-load-packages \`
                          (pruviloj))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (winum toml-mode racer cargo rust-mode auctex-latexmk yapfify yaml-mode xterm-color ws-butler window-numbering which-key web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spacemacs-theme spaceline smeargle shell-pop restart-emacs rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree multi-term move-text magit-gitflow macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint kakapo-mode json-mode js2-refactor js-doc intero info+ indent-guide idris-mode ido-vertical-mode hy-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-ag haskell-snippets google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help elisp-slime-nav dumb-jump diff-hl define-word cython-mode company-ghci company-ghc column-enforce-mode coffee-mode cmm-mode clean-aindent-mode auto-highlight-symbol auto-compile auctex anaconda-mode aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
