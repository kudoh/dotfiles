(defvar lune-mode-map (make-sparse-keymap) "local key map")
(let ((key ?a))
  (while (<= key ?z)
    (define-key lune-mode-map (char-to-string key) 'lune-i-am)
    (setq key (+ 1 key))))

(let* ((jibaku (random 26))
       (key (char-to-string (+ ?a jibaku))))
  (define-key lune-mode-map key 'lune-jibaku))

(defun lune-mode()
  "this is lune mode"
  (interactive)
  (setq major-mode 'lune-mode
        mode-name "lune mode")
  (use-local-map lune-mode-map))

(defun lune-jibaku ()
  "jibaku"
  (interactive)
  (let ((visible-bell t))
    (ding)
    (sit-for 1)
    (ding)
    (sit-for 1)
    (ding)
    (sit-for 1)
    (erase-buffer)
    (message "jibaku")))

(defun lune-i-am ()
  "search and increment, if nothing insert"
  (interactive)
  (let ((p (point)) n (thiskey (upcase (this-command-keys))))
    (goto-char (point-min))
    (if (re-search-forward
         (format "novo%s\\([0-9]*\\)desu" thiskey) nil t)
        (if (match-beginning 1)
            (progn
              (setq n (match-string 1))
              (setq n (+ (string-to-number n) 1))
              (goto-char (1- (match-beginning 1)))
              (delete-region
               (point)
               (match-end 1))
              (insert (format "%s%d" thiskey n)))
          (delete-region
           (match-beginning 0) (match-end 0))
          (insert (format "novo%s2desu" thiskey)))
      (goto-char (point-max))
      (insert (format "novo%sdesu" thiskey)))))
