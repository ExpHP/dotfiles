;;; -*- lexical-binding: t -*-

(cl-defun my-mode-hook (hook &key (kako t) (w 2) tabs (scold-spacemacs t) prog)
  (let ((twidth w)
        (tmode tabs)
        (tkako-yn kako)
        (prog prog)
        (hook hook)
        (scold-spacemacs scold-spacemacs)
        (tkako-int (if kako 1 0)))

    (add-hook hook
              (lambda ()
                (kakapo-mode tkako-int)
                (setq-local indent-tabs-mode tmode) ; controls tabs vs spaces in most places
                (setq-local evil-shift-width twidth) ; evil < and > width
                (setq-local tab-width twidth) ; hard-tab display width
                (setq-local kakapoconf--has-local-control t)

                (when tkako-yn
                  ;; NOTE: I don't think there's any simple mechanism avaiable to recover any keybindings that we overwrite...?
                  (evil-local-set-key 'normal "O" 'kakapoconf/open-above)
                  (evil-local-set-key 'normal "o" 'kakapoconf/open-below)
                  (evil-local-set-key 'insert (kbd "RET") 'kakapo-ret-and-indent)
                  (evil-local-set-key 'insert (kbd "<S-backspace>") 'kakapo-upline)

                  ;; GOTCHA!
                  ;; THIS was the culprit that was causing backspace to delete
                  ;;   to "magic tabstops" literally everywhere in a line.
                  ;; kakapo-mode, I thought you cared about the distinction between
                  ;;   indentation and alignment! I THOUGHT WE WERE FRIENDS ;_;
                  ;; (evil-local-set-key 'insert (kbd "DEL") 'kakapo-backspace)
                  )

                (progn prog)))))

;; These are here to give something that can show up with a keybinding next to
;;  it in an M-x search.
(defun kakapoconf/open-above () (interactive) (kakapo-open t))
(defun kakapoconf/open-below () (interactive) (kakapo-open nil))

(defconst kakapoconf/mode-defaults
  '((python-mode-hook :w 4 :tabs t)
    ;; FIXME I should make a PR to haskell-mode to fix error span
    ;;  underlining for tabs
    (haskell-mode-hook :w 4 :tabs nil
                       :prog ((haskell-indentation-mode 0)))
    (shell-mode-hook :w 4 :tabs t)
    ;; sorry rustfmt, you're still not ready
    (rust-mode-hook :w 4 :tabs t)

    ;; elisp is structured enough that auto-indentation is actually *a delight*.
    (emacs-lisp-mode-hook :kako nil :w 2 :tabs nil)))

(defun kakapoconf/maybe-let-spacemacs-set-evil-shift-width ()
  " Callback to replace spacemacs//set-evil-shift-width, which respects our config settings
    in cases where we have the buffer under control. "
  (when (not kakapoconf--has-local-control)
    (spacemacs//set-evil-shift-width)))


;; NOTE: original config file also had the notion of "project" settings based on location.  Could be useful.
;;       The trouble is, I would want to check them even for modes not in mode-defaults
;;       (the original settings file could do this because it used hooks on text-mode and prog-mode)
;;       but I would want them to take precedence over the mode settings
;;       (those general mode hooks run too early for this)
(defun kakapoconf-global-init ()
  (setq-default kakapoconf--has-local-control nil)

  ;; NOTE: set-evil-shift-width was set globally, so it can only be removed globally
  (remove-hook 'after-change-major-mode-hook 'spacemacs//set-evil-shift-width)
  ;; ...hence the replacement.
  (add-hook 'after-change-major-mode-hook 'kakapoconf/maybe-let-spacemacs-set-evil-shift-width)

  (dolist (entry kakapoconf/mode-defaults)
    (apply 'my-mode-hook entry)))
