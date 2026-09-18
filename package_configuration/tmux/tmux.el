;;; tmux-foot.el -*- lexical-binding: t; -*-

(defun tmux-open-dir (path)
  "Open PATH in a new window inside the most recently active tmux session.
If no tmux session exists, launch foot running a new tmux session."
  (let ((dir (expand-file-name path)))
    ;; Check if ANY tmux session is currently active
    (if (zerop (call-process "tmux" nil nil nil "has-session"))
        ;; Session exists: create new window in active session
        (start-process "tmux-new-window" nil "tmux" "new-window" "-c" dir)
      ;; No session exists: start foot with a fresh tmux session
      (start-process "foot-tmux" nil "foot" "tmux" "new-session" "-c" dir))))

(defun treemacs-visit-node-in-tmux ()
  "Open directory at node in the active tmux session."
  (interactive)
  (-if-let (path (treemacs--prop-at-point :path))
      (let ((process-connection-type nil)
            (dir-path (if (f-dir? path)
                          path
                        (file-name-directory path))))
        (message dir-path)
        (tmux-open-dir dir-path))
    (treemacs-pulse-on-failure "Nothing to open here.")))

(defun tmux-open-current-file-dir ()
  "Open the current file's directory in tmux."
  (interactive)
  (let ((path (or buffer-file-name default-directory)))
    (tmux-open-dir (file-name-directory path))))

(defun tmux-open-current-project-dir ()
  "Open the current project root in tmux."
  (interactive)
  (tmux-open-dir (doom-project-root)))

(map!
  :leader
  "fg" #'tmux-open-current-file-dir
  "pg" #'tmux-open-current-project-dir)

(map!
  :map treemacs-mode-map
  "og" #'treemacs-visit-node-in-tmux)


