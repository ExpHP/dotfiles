

(defcustom framegeometry-path "~/.emacs.d/framegeometry"
  "Persistent file for saving OS window geometry between emacs sessions.")

(defun framegeometry-save ()
  "Saves the current frame's geometry to framegeometry-path."
  (let (
        (framegeometry-left (frame-parameter (selected-frame) 'left))
        (framegeometry-top (frame-parameter (selected-frame) 'top))
        (framegeometry-width (frame-parameter (selected-frame) 'width))
        (framegeometry-height (frame-parameter (selected-frame) 'height))
        (framegeometry-file (expand-file-name framegeometry-path))
        )

    (when (not (number-or-marker-p framegeometry-left))
      (setq framegeometry-left 0))
    (when (not (number-or-marker-p framegeometry-top))
      (setq framegeometry-top 0))
    (when (not (number-or-marker-p framegeometry-width))
      (setq framegeometry-width 0))
    (when (not (number-or-marker-p framegeometry-height))
      (setq framegeometry-height 0))

    (with-temp-buffer
      (insert
       ";;; This is the previous emacs frame's geometry.\n"
       ";;; Last generated " (current-time-string) ".\n"
       "(setq initial-frame-alist\n"
       "      '(\n"
       (format "        (top . %d)\n" (max framegeometry-top 0))
       (format "        (left . %d)\n" (max framegeometry-left 0))
       (format "        (width . %d)\n" (max framegeometry-width 0))
       (format "        (height . %d)))\n" (max framegeometry-height 0))
       )
      (when (file-writable-p framegeometry-file)
        (write-file framegeometry-file)))
    )
  )

(defun framegeometry-restore ()
  "Loads frame geometry from framegeometry-path."
  (let ((framegeometry-file (expand-file-name framegeometry-path)))
    (when (file-readable-p framegeometry-file)
      (load-file framegeometry-file)))
  )

(defun framegeometry-hatsudou!! ()
  "Set up hooks to automatically save and restore frame geometry."
  (when window-system
    (add-hook 'after-init-hook 'framegeometry-restore)
    (add-hook 'kill-emacs-hook 'framegeometry-save)
    )) 
