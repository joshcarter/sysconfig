;;; josh-addons.el --- Josh's custom elisp functions  -*- lexical-binding: t; -*-

(defvar last-last-command nil
  "The command before `last-command', used by `home' and `end'.")

(defun josh-buffer-menu (arg)
  (interactive "P")
  (buffer-menu-other-window))

(defun forward-ten-lines (arg)
  "Move forward ten lines."
  (interactive "P")
  (forward-line 10))
(define-key global-map "\C-n" 'forward-ten-lines)

(defun backward-ten-lines (arg)
  "Move backwards ten lines."
  (interactive "P")
  (forward-line -10))
(define-key global-map "\C-p" 'backward-ten-lines)

(defun switch-buffer-and-compile (arg)
  "Switch to compilation buffer, then compile."
  (interactive "P")
  (switch-to-buffer "*compilation*")
  (compile "make"))

(defun home ()
  "Home - begin of line, once more - screen, once more - buffer."
  (interactive nil)
  (cond
   ((and (eq last-command 'home) (eq last-last-command 'home))
    (goto-char (point-min)))
   ((eq last-command 'home)
    (move-to-window-line 0))
   (t
    (beginning-of-line)))
  (setq last-last-command last-command))
(global-set-key "\C-a" 'home)

(defun end ()
  "End - end of line, once more - screen, once more - buffer."
  (interactive nil)
  (cond
   ((and (eq last-command 'end) (eq last-last-command 'end))
    (goto-char (point-max)))
   ((eq last-command 'end)
    (move-to-window-line -1)
    (end-of-line))
   (t
    (end-of-line)))
  (setq last-last-command last-command))
(global-set-key "\C-e" 'end)

(defun beginning-of-window ()
  (interactive)
  (move-to-window-line 0))

(defun end-of-window ()
  (interactive)
  (move-to-window-line -1)
  (end-of-line))

(provide 'josh-addons)

;;; josh-addons.el ends here
