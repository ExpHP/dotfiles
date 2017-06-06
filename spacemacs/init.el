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
     html
     racket
     markdown
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
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
     common-lisp

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
   dotspacemacs-additional-packages
   '(
     kakapo-mode
     flycheck
     flycheck-rust
     dtrt-indent
   )
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
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
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
   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
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
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, `J' and `K' move lines up and down when in visual mode.
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
   ;; If non-nil then the last auto saved layouts are resumed automatically upon
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
   ;; If non-nil the paste micro-state is enabled. When enabled pressing `p'
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.1
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
   dotspacemacs-maximized-at-startup t
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
   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
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
   ;; PERSONAL NOTE: this sounds enticing, but you need to make sure everything
   ;;                possible uses 'emacsclient --alternate-editor ""' instead
   ;;                of plain old 'emacs' (which would create an endless horde
   ;;                of undying servers)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   dotspacemacs-frame-title-format "%I@%S"
   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil
   ))

(defun dotspacemacs//emacs-capture-p ()
  "determine if we were called from capture-mode"
  (equal "emacs-capture" (frame-parameter nil 'name)))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  ;;; don't bother with this. dotspacemacs-maximized-at-startup is perfect.
  ;; (load "~/dotfiles/spacemacs/framegeometry")
  ;; (setq framegeometry-path "~/dotfiles/spacemacs/var/framegeometry")
  ;; (framegeometry-hatsudou!!)
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
    (when (looking-at-p "import")

      (if (looking-at from-qual)
          (replace-match to-unqual)
        (looking-at from-unqual)
        (replace-match to-qual)))))

;; TODO do something with this
;; (also, "vioiIiIiI..." selects progressively larger blocks by indentation)
(defconst dotspacemacs/haskell-select-function "viioip")

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

   FIXME:  Wow.  Words cannot describe just how broken this is.
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

;; implements David Allen's advice on page 123 to handle the in-box strictly one item at a time

(defconst dotspacemacs/gtd-inbox-item-format "~/org/inbox/item-%03d.org")
(defun dotspacemacs/gtd/path-is-inbox-item (path) (s-contains? "org/inbox/item" path))

;; "Do the simplest thing that could possibly work."
;; We need some way to identify when the inbox is empty,
;;  and most other solutions I can think of have issues of atomicity,
;;  or difficulty telling true inbox items apart from temp files.
;;  Or difficulty escaping regexes.  You get the idea.
;;
;; A thousand calls to stat isn't THAT expensive...
(defconst dotspacemacs/gtd-inbox-item-limit 999 "inclusive upper bound on item index")

(defun dotspacemacs//gtd-inbox-push-new ()
    "function-finding-location for org-capture-templates which visits a brand new file for each item"
    (let ((fp (dotspacemacs//first-new-file dotspacemacs/gtd-inbox-item-format
                                            ;; "Do the simplest thing that could possibly work."
                                            ;; We need some way to identify when the inbox is empty,
                                            ;;  and most other solutions I can think of have issues of atomicity,
                                            ;;  or difficulty telling true inbox items apart from temp files.
                                            dotspacemacs/gtd-inbox-item-limit
                                            (lambda () (error "too many items in in-box!")))))

      ;; The docstring of `org-capture-templates' says the function should "visit" the file, which is vague.
      ;; My attempts using functions of the `find-file' family produced undesirable or even bizarre behavior, like double cursors.
      ;;
      ;; After some code sleuthing, this is all I could come up with that actually behaves like the other types of target spec.
      (set-buffer (org-capture-target-buffer fp))

      ;; HACK:  Man, talk about side-effects!
      ;; We save now so that the file appears immediately in the filesystem.
      ;; Otherwise, forgetting to close a capture window would cause any new captures to be inserted
      ;;  into the same file.
      (save-buffer)
      ))


;; NOTE ON CAPTURE FUNCTIONS:
;;
;; The docstring of `org-capture-templates' says the function should "visit" the file, which is vague.
;; My attempts using functions of the `find-file' family produced undesirable or even bizarre behavior, like double cursors.
;;
;; After some code sleuthing, this is all I could come up with that actually behaves like the other types of target spec.
;;
;;       (set-buffer (org-capture-target-buffer fp))

(defun dotspacemacs//gtd-inbox-push-new ()
    "function-finding-location for org-capture-templates which visits a brand new file for each item"
    (let ((fp (dotspacemacs//first-new-file dotspacemacs/gtd-inbox-item-format
                                            ;; "Do the simplest thing that could possibly work."
                                            ;; We need some way to identify when the inbox is empty,
                                            ;;  and most other solutions I can think of have issues of atomicity,
                                            ;;  or difficulty telling true inbox items apart from temp files.
                                            dotspacemacs/gtd-inbox-item-limit
                                            (lambda () (error "too many items in in-box!")))))

      ;; See NOTE ON CAPTURE FUNCTIONS
      (set-buffer (org-capture-target-buffer fp))

      ;; HACK:  Man, talk about side-effects!
      ;; We save now so that the file appears immediately in the filesystem.
      ;; Otherwise, forgetting to close a capture window would cause any new captures to be inserted
      ;;  into the same file.
      (save-buffer)
    ))

(defun dotspacemacs//gtd-inbox-view-top ()
    "open a file for an inbox item"
    (interactive)
    (let ((fp (dotspacemacs//first-existing-file dotspacemacs/gtd-inbox-item-format
                                                 dotspacemacs/gtd-inbox-item-limit)))

      (if fp
          (progn
            (find-file fp)
            (org-cycle 16))
        (message "nothing left to review!"))))

(defun dotspacemacs//gtd-projectile-location-func ()
  ;; See NOTE ON CAPTURE FUNCTIONS
  (set-buffer (org-capture-target-buffer
               (car (org-projectile:todo-files))))
  )

;; (defun dotspacemacs//gtd/current-inbox-item-to-tickler (time)
;;   "send an inbox item to the tickler"
;;   )

;; (defun dotspacemacs/gtd/refile-to-tickler (time)
;;   "refile something to the tickler"
;;   (unless (dotspacemacs/gtd/path-is-inbox-item (buffer-file-name))
;;     (error "not in an inbox item!"))
;;   (goto-char (point-min))
;;   (org-schedule nil time)
;;   (dotspacemacs/gtd//refile "~/org/tickle.org")
;;   (if (s-blank-str? ()))
;;   )

;; (defun dotspacemacs/gtd//refile (file headline)
;;   "non-interactively refile to a known destination.
;; https://emacs.stackexchange.com/questions/8045/org-refile-to-a-known-fixed-location"
;;   (let ((pos (save-excursion
;;                (find-file file)
;;                (org-find-exact-headline-in-buffer headline))))
;;     (org-refile nil nil (list headline file nil pos))))

(defun dotspacemacs//get-string-from-file (fp)
  "Read an entire file to string. This is as bad of an idea as it sounds."
  (with-temp-buffer
    (insert-file-contents fp)
    (buffer-string)))

(defun dotspacemacs//file-is-blank (fp)
  "Test if a file is all whitespace. DO NOT USE ON LARGE FILES."
  (s-blank-str? (dotspacemacs//get-string-from-file fp)))

(defun dotspacemacs//delete-blank-files (pattern limit)
  "Used by inbox functions to auto-delete blank files.

This is of course a terrible hack, but I think it's a fair bit safer than providing
a delete-without-confirmation keybind."
  (loop for i from 1 to limit
        for fp = (format pattern i)
        if (and (file-exists-p fp) (dotspacemacs//file-is-blank fp))
        do (spacemacs/delete-file fp)))

(defun dotspacemacs//first-new-file (pattern limit &optional limit-exceeded)
  (dotspacemacs//delete-blank-files pattern limit) ; FIXME evil side-effect
  (let ((limit-exceeded (or limit-exceeded (lambda () nil))))
    (loop for i from 1
          if (< limit i)
          return (funcall limit-exceeded)
          for fp = (format pattern i)
          if (not (file-exists-p fp))
          return fp)))

(defun dotspacemacs//first-existing-file (pattern limit &optional limit-exceeded)
  (dotspacemacs//delete-blank-files pattern limit) ; FIXME evil side-effect
  (let ((limit-exceeded (or limit-exceeded (lambda () nil))))
    (loop for i from 1
          if (< limit i)
          return (funcall limit-exceeded)
          for fp = (format pattern i)
          if (file-exists-p fp) ; <-- that's the only difference.  too bad I suck at macros
          return fp)))

;;=========================================

;;; Org-capturing from external applications.
;;; Part of a greater picture described here: http://www.diegoberrocal.com/blog/2015/08/19/org-protocol/

(defun dotspacemacs//configure-org-capture-popups ()
  ;; Thank you random guy from StackOverflow
  ;; http://stackoverflow.com/questions/23517372/hook-or-advice-when-aborting-org-capture-before-template-selection

  (defadvice org-capture
      (after make-full-window-frame activate)
    "Advise capture to be the only window when used as a popup"
    (if (dotspacemacs//emacs-capture-p)
        (delete-other-windows)))

  (defadvice org-capture-finalize
      (after delete-capture-frame activate)
    "Advise capture-finalize to close the frame"
    (if (dotspacemacs//emacs-capture-p)
        (delete-frame)))
)

;;=========================================

(defvar dotspacemacs//org-capture-keymap (make-keymap)
  "Keymap used in place of org's dumb interactive selection window. Manually maintained.")

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

  ;; FIXME this seems out of place.  Also, shouldn't it be in a with-eval-after-load?
  (setq rust-indent-offset 4)

  ;; config for captures made via org-protocol://
  (dotspacemacs//configure-org-capture-popups)

  ;; Enable handler for org-protocol:// links.
  ;; (This must be explicitly loaded since it doesn't fit into the spacemacs
  ;;  design philosophy of "call function, auto-load module")
  (require 'org-protocol)

  (with-eval-after-load 'org-capture

    (setq org-capture-templates nil)

    ;; in-box capturing on SPC a o c c
    ;;   - must be as easy as possible to throw something in here; 5 seconds from start to finish
    ;;   - we use separate files per inbox item, to avoid the trap of wandering eyes
    ;;   - captures a link from the point of invocation; it won't always be relevant,
    ;;      but who cares? Nothing remains in the inbox for long.
    (defun dotspacemacs/capture-inbox () (interactive) (org-capture nil "c"))
    (define-key dotspacemacs//org-capture-keymap "c" 'dotspacemacs/capture-inbox)
    (add-to-list 'org-capture-templates '("c" "inbox" entry
                                         (function dotspacemacs//gtd-inbox-push-new)
                                         "* %?\n  Captured: %T\n  %a"))

    ;; projectile-based capturing on SPC a o c p
    ;; There is already `org-projectile:capture-for-current-project' but it behaves strangely.
    ;;  (generates two windows pointing to the same buffer.)
    (defun dotspacemacs/capture-projectile () (interactive) (org-capture nil "p"))
    (define-key dotspacemacs//org-capture-keymap "p" 'dotspacemacs/capture-projectile)
    (add-to-list 'org-capture-templates '("p" "projectile" entry
                                          (function dotspacemacs//gtd-projectile-location-func)
                                          "* TODO %?\n  Captured: %T\n  %a"))

    ;; Inbox, from external applications
    (add-to-list 'org-capture-templates '("L" "DO NOT USE" entry
                                          (function dotspacemacs//gtd-inbox-push-new)
                                          "* %?\n  %i \n  Captured: %T\n  %a"))

    ;; captures should start in insert mode
    (add-hook 'org-capture-mode-hook 'evil-insert-state)
    )

  ;; load it now so that our keybinds are added and our functions exist
  (require 'org-capture)

  (spacemacs/set-leader-keys
    ;; Replace org-capture's interactive selection window with a garden-variety prefix.
    ;; This eliminates a bug where it is possible to enter your selection "too fast"
    ;; (e.g. typing "SPC a o c p" too quickly will yank the kill ring)
    "a o c" dotspacemacs//org-capture-keymap

    ;; accidentally opening the calculator when trying to capture leads to misery
    "a c" nil
    "a c o" dotspacemacs//org-capture-keymap

    ;; The built-in implementation for this guy seems buggy. Replace it with ours.
    "a o p" 'dotspacemacs/capture-projectile
    )

  ;; Targets for manual refiling.
  (with-eval-after-load 'org
    (setq org-refile-targets '(("~/org/tickle.org" :level . 1)
                               ("~/org/projects.org" :level . 1)
                               ("~/org/someday.org" :level . 2)
                               ))

    ;; org-refile does not automatically save the current file. This is annoying.
    ;; It also does not save its changes to the destination file. THIS IS TERRIFYING.
    (advice-add 'org-refile :after
                (lambda (&rest _)
                  (org-save-all-org-buffers)))

    ;; personal package not wrapped in a layer
    (load "~/dotfiles/spacemacs/org-action-verbs")
    )

  (add-to-list 'auto-mode-alist '("\\.gplot$" . gnuplot-mode))
  (add-to-list 'auto-mode-alist '("\\.gplot.template$" . gnuplot-mode))
  (add-to-list 'auto-mode-alist '("\\.gnuplot$" . gnuplot-mode))
  (add-to-list 'interpreter-mode-alist '("gnuplot" . gnuplot-mode))

  ;; Old habits die hard.  Accidentally quitting emacs sucks.
  (evil-ex-define-cmd "q[uit]" nil)
  (evil-ex-define-cmd "wq" nil)

  ;; My org capture system visits lots of files.
  ;; Don't let that compromise the utility of SPC f r.
  (with-eval-after-load 'recentf
    (add-to-list 'recentf-exclude "/org/inbox/"))

  (setq personal-abbrev-file-name "~/dotfiles/spacemacs/abbrev_defs")
  ;;; Meh, abbrev mode isn't good enough.
  ;; (setq abbrev-file-name personal-abbrev-file-name)
  ;; (dolist (x '((haskell-mode . haskell-mode-hook))
  ;;            (with-eval-after-load (car x)
  ;;              (add-hook (cdr x)
  ;;                        ;; electric-indent-mode insidiously replaces the abbrevs file!
  ;;                        ;; ...I think?
  ;;                        (lambda ()
  ;;                          (electric-indent-mode 0)
  ;;                          (abbrev-mode) ; this doesn't seem to actually
  ;;                                        ; enable it.  Docs say to supply a
  ;;                                        ; positive argument in interactive
  ;;                                        ; use, and nil in noninteractive use.
  ;;                          (read-abbrev-file personal-abbrev-file-name))))))

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
    ;; slippery fingers, ya know
    "s f" 'save-buffer
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

  (setq compilation-ask-about-save nil)
  (with-eval-after-load 'slime
    ;; annoying yes/no prompt every time you have a compile error
    (setq slime-load-failed-fasl 'never)

    ;; disable the debugger
    (let ((text "(setf *debugger-hook* (lambda (c h) (declare (ignore h) (ignore c)) (abort)))"))

      ;;  AGGGHGHGHGHGHGHGH
      ;;  Nothing works!
      ;;  NOTHING! GODDAMN! WORKS!!!!!!!

      ;; NOTE: If you MANUALLY paste the above text into the repl and hit enter, it will,
      ;;       in fact, disable the debugger. But if you try to do it in any sort of fashion
      ;;       which can be automated, it won't work.

      ;; I tried:
      ;;
      ;;   * putting the text in .sbclrc
      ;;      (SLIME verifiably reads this file, but the debugger remains)
      ;;
      ;;   * M-: (slime-interactive-eval text)
      ;;      (prints result of setf to a status minibuffer; debugger remains)
      ;;
      ;;   * M-: (slime-eval '<text recast as an emacs sexp>)
      ;;      (slime debugger pops up with
      ;;       "The variable SWANK-IO-PACKAGE::*DEBUGGER-HOOK* is unbound.")
      ;;
      ;;   * M-: (slime-repl-eval-string text)
      ;;      (prints result directly into the REPL, and yet the debugger STILL REMAINS!)
      ;;
      ;;   * M-: (slime-repl-send-string text)
      ;;      (same as slime-repl-eval-string.)
      ;;
      ;;   * replacing "setf" with "defparameter" in the above
      ;;      (first the SLIME debugger pops up saying the symbol is protected,
      ;;        but if you press 2 you can unlock it.
      ;;        If you try again, it prints *DEBUGGER-HOOK* to the REPL...
      ;;        ...but the debugger. still. remains.
      ;;
      ;;       Evaluating *debugger-hook* in the REPL after this still results in
      ;;         #<FUNCTION SWANK:SWANK-DEBUGGER-HOOK>
      ;;       even though setting/overwriting any other global variable works just fine:
      ;;         M-: (slime-repl-send-string "(defparameter b 3)") ;; B evals to 3 in repl
      ;;         M-: (slime-repl-send-string "(defparameter b 4)") ;; B now evals to 4
      ;;      )
      ;;
      ;;   * replacing "setf" with "cl:defparameter", which is what the
      ;;     interactive command `slime-repl-defparameter' uses internally.
      ;;      (same result as defparameter)
      ;;
      ;;   * trying setf with swank/swank-debugger-hook instead of *debugger-hook*
      ;;      (prints result of setf, no effect)
      ;;
      ;; Insofar as I can tell, nothing works except manual copy pasta!

      ;; TEST CASE:
      ;;   Go to the slime repl and enter the expression:  a
      ;;
      ;;   Desired behavior:
      ;;      CL-USER> a
      ;;      ; Evaluation aborted on #<UNBOUND-VARIABLE A {1004972D93}>.
      ;;      CL-USER>
      ;;
      ;;   Observed behavior: (i.e. what I mean when I say "the debugger remains")
      ;;      (opens debugger with "The variable A is unbound.")
      )

    ;; AHAH! NO WORMING YOUR WAY OUTTA THIS ONE!
    ;; BURN IN HELL YOU MODAL PIECE OF SHIT
    ;; DEATH TO THE EASY-MENU!!!
    ;; DEATH TO THE EASY-MENU!!!
    ;; HRRRRNGGGWRRRRRRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAGHGHGHGHGHG
    (add-hook 'sldb-hook 'sldb-quit)
    ;;
    ;; ...
    ;;
    ;; ...right, so.  The above line makes the swank debugger instantly quit.
    ;; At this point, I am more or less thoroughly convinced that this is
    ;; the closest we're ever gonna get to disabling the debugger (at least,
    ;;  without having to explicitly type something into the repl every time)
    ;;
    ;; On the downside, I can no longer *manually* invoke it, either.
    ;; ...Meh. I guess the two of us just weren't meant to be.
    )

  ;; Universally stop asking for permission to kill processes.
  ;; NOTE: This is superior to modifying kill-buffer-query-functions,
  ;;       which only impacts `SPC b d' (but not e.g. `SPC q q')
  (defadvice process-query-on-exit-flag (around advice--process-query-on-exit-flag--never activate)
    nil)

  (with-eval-after-load 'haskell-mode
    (add-hook 'haskell-mode-hook
              (lambda ()
                (add-hook 'before-save-hook
                          'dotspacemacs/brazenly-replace-things
                          nil t))))

  (with-eval-after-load 'haskell-mode
    (add-hook 'haskell-mode-hook
              (lambda ()
                ;; I tried to give it a chance.  I really did.
                ;; But even after >2 months, I still feel *nothing but relief* whenever I find
                ;;  myself in a buffer where smartparens is disabled
                (turn-off-smartparens-mode))
              ))

  (with-eval-after-load 'haskell-mode
    (spacemacs/declare-prefix-for-mode 'haskell-mode "mi" "haskell/intero")
    (spacemacs/set-leader-keys-for-major-mode 'haskell-mode
      "ii" 'intero-mode
      "ir" 'intero-restart
      "it" 'intero-targets
      "dq" 'dotspacemacs//haskell-toggle-qualified
      ))

  (with-eval-after-load 'org
    ;; default keybind needs shift. blech
    (spacemacs/set-leader-keys-for-major-mode 'org-mode
      "r" 'org-refile
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

  (with-eval-after-load 'org
    ;; a.k.a line-wrap
    (add-hook 'org-mode-hook 'spacemacs/toggle-visual-line-navigation-on))

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
    (web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data racket-mode faceup symon string-inflection yapfify yaml-mode xterm-color ws-butler winum which-key web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toml-mode toc-org spaceline smeargle slime-company shell-pop restart-emacs rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree multi-term move-text mmm-mode markdown-toc magit-gitflow lush-theme lorem-ipsum livid-mode live-py-mode linum-relative link-hint kakapo-mode json-mode js2-refactor js-doc intero info+ indent-guide idris-mode hy-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-purpose helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help elisp-slime-nav dumb-jump dtrt-indent diff-hl define-word cython-mode company-tern company-statistics company-quickhelp company-ghci company-ghc company-cabal company-auctex company-anaconda common-lisp-snippets column-enforce-mode coffee-mode cmm-mode clean-aindent-mode cargo browse-at-remote auto-yasnippet auto-highlight-symbol auto-compile auctex-latexmk aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
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
