;; josh's custom elisp stuff

(defun josh-revert-doit (arg)
  (interactive "P")
  (revert-buffer t)
)
(define-key global-map "\C-xv" 'josh-revert-doit)

(defun josh-buffer-menu (arg)
  (interactive "P")
;  (split-window)
  (buffer-menu-other-window)
)

(defun forward-ten-lines (arg)
  "move forward ten lines"
  (interactive "P")
  (forward-line 10)
)
(define-key global-map "\C-n" 'forward-ten-lines)

(defun backward-ten-lines (arg)
  "move backwards ten lines"
  (interactive "P")
  (forward-line -10)
)
(define-key global-map "\C-p" 'backward-ten-lines)

(defun switch-buffer-and-compile (arg)
  "switch to compilation buffer, then compile"
  (interactive "P")
  (switch-to-buffer "*compilation*")
  (compile "make")
)

(defun home ()
  "Home - begin of line, once more - screen, once more - buffer."
  (interactive nil)
  (cond
   ((and (eq last-command 'home) (eq last-last-command 'home))
    (goto-char (point-min))
    )
   ((eq last-command 'home)
    (move-to-window-line 0)
    )
   (t
    (beginning-of-line)
    )
   )
  (setq last-last-command last-command)
)
(global-set-key "\C-a" 'home)
 
(defun end ()
  "End - end of line, once more - screen, once more - buffer."
  (interactive nil)
  (cond
   ((and (eq last-command 'end) (eq last-last-command 'end))
    (goto-char (point-max))
    )
   ((eq last-command 'end)
    (move-to-window-line -1)
    (end-of-line)
    )
   (t
    (end-of-line)
    )
   )
  (setq last-last-command last-command)
)
(global-set-key "\C-e" 'end)
 
(defun beginning-of-window ()
  (interactive)
  (move-to-window-line 0))
 
(defun end-of-window ()
  (interactive)
  (move-to-window-line -1)
  (end-of-line))
 
(defun josh-insert-change-comment (arg)
  "insert my standard time/date stamp for making changes to stuff"
  (interactive "P")
  (save-excursion
    (insert "/*** jdc change * ")
    (shell-command "date" t)
      (delete-char 4)
      (forward-word 2)
      (let ((beg (point)))
	(forward-word 4)
	(delete-region beg (point)))
    (end-of-line)
    (insert " ***/"))
)

; make ';' insert self and indent line, but not insert newline.
(defun electric-c-semi (arg)
  "Insert character and correct line's indentation."
  (interactive "P")
  (self-insert-command (prefix-numeric-value arg)))
;  (if c-auto-newline
;      (electric-c-terminator arg)
;    (self-insert-command (prefix-numeric-value arg))))
; deactivate -- use c-hanging-semi&comma-criteria instead
; (define-key c-mode-map ";" 'electric-c-semi)
; (define-key c++-mode-map ";" 'electric-c-semi)

; make '{' do the right thing for me
(defun josh-electric-c-leftbrace (arg)
  "Insert { character and correct line's indentation.
Then insert a newline and a }, correctly indented.
Return point to just after the {.  If c-auto-newline is non-nil,
insert a newline and leave the cursor (and point) indented on
the blank line between the braces."
  (interactive "P")
  (c-electric-brace (prefix-numeric-value arg))
  (c-indent-line)
  (insert "\n" "}")
  (c-indent-line)
  (previous-line 1)
  (end-of-line nil)
  (newline-and-indent)
)
; (define-key c-mode-map "{" 'josh-electric-c-leftbrace)
; (define-key c++-mode-map "{" 'josh-electric-c-leftbrace)

;; josh's special commenting style, stolen from Pierre Omidyar
;; (the commenting style is stolen, that is, not the code;
;;  pierre hates emacs)
(defun pierre-comment (arg)
  "Always comment the way I want it in c-mode. Always. Really."
  (interactive "P")
  (beginning-of-line)
  (c-indent-line)
  (if (not (save-excursion
	     (forward-line -1)
	     (looking-at "[ \t]*[\n{]")))
      (newline-and-indent))
  (insert "/*\n** ")
  (c-indent-line)
  ;; not sure if this next line will be good or not.. -jdc
  (set-fill-prefix)
  (save-excursion
    (insert "\n*/")
    (c-indent-line)
    (if (not (looking-at "[ \t]*\n"))
	(newline-and-indent))))

;; josh's special commenting style, stolen from General Magic
(defun josh-comment (arg)
  "Always comment the way I want it in c-mode. Always. Really."
  (interactive "P")
  (beginning-of-line)
  (c-indent-line)
  (if (not (save-excursion
	     (forward-line -1)
	     (looking-at "[ \t]*[\n{]")))
      (newline-and-indent))
  (insert "/* ")
  (c-indent-line)
  (save-excursion
    (insert "\n*/")
    (c-indent-line)
    (if (not (looking-at "[ \t]*\n"))
	(newline-and-indent))))
; (define-key c-mode-map "\e;" 'josh-comment)
; (define-key c++-mode-map "\e;" 'josh-comment)
; (define-key java-mode-map "\e;" 'josh-comment)

;; josh's custom comment-aware fill command for c-mode
;; note: only works with above comment style!
(defun josh-fill-comment (arg)
  (interactive "P")
  (save-excursion
    (beginning-of-line)
    (if (not (or (looking-at "[ \t]*\\*\\*")
		 (and (looking-at "[ \t]*/\\*") (forward-line 1))
		 (and (looking-at "[ \t]*\\*/") (forward-line -1))))
	;; if not in josh-style comment, just fill paragraph
	(fill-paragraph nil)
      ;; else
      (re-search-backward "[ \t]*/\\*")
      (forward-line 1)
      (beginning-of-line)
      (insert "\n")
      (re-search-forward "[ \t]*\\*/")
      (beginning-of-line)
      (insert "\n")
      (forward-line -2)
      (beginning-of-line)
      (search-forward "** ")
      (set-fill-prefix)
      (fill-paragraph nil)
      (re-search-backward "[ \t]*/\\*")
      (forward-line 1)
      (kill-line nil)
      (re-search-forward "[ \t]*\\*/")
      (forward-line -1)
      (kill-line nil))))
; (define-key c-mode-map "\M-q" 'josh-fill-comment)
; (define-key c++-mode-map "\M-q" 'josh-fill-comment)

;; Switches between source/header files
;; swiped from http://www.dotemacs.de/dotfiles/JanBorsodi/JanBorsodi.emacs.html
;; xxx not working
(defun toggle-source-header()
  "Switches to the source buffer if currently in the header buffer and vice versa."
  (interactive)
  (let ((buf (current-buffer))
        (name (file-name-nondirectory (buffer-file-name)))
        file
        offs)
    (setq offs (string-match c++-header-ext-regexp name))
    (if offs
        (let ((lst c++-source-extension-list)
              (ok nil)
              ext)
          (setq file (substring name 0 offs))
          (while (and lst (not ok))
            (setq ext (car lst))
            (if (file-exists-p (concat file "." ext))
                  (setq ok t))
            (setq lst (cdr lst)))
          (if ok
              (find-file (concat file "." ext))))
      (let ()
        (setq offs (string-match c++-source-ext-regexp name))
        (if offs
            (let ((lst c++-header-extension-list)
                  (ok nil)
                  ext)
              (setq file (substring name 0 offs))
              (while (and lst (not ok))
                (setq ext (car lst))
                (if (file-exists-p (concat file "." ext))
                    (setq ok t))
                (setq lst (cdr lst)))
              (if ok
                  (find-file (concat file "." ext)))))))))
