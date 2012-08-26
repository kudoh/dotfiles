(defvar novo-mode-map (make-sparse-keymap) "novo's practice")
;; set key bindings to buffer local key map
(let ((key ?a))
  (while (<= key ?z)
    (define-key novo-mode-map (char-to-string key) 'novo-i-am)
    (setq key (1+ key))))

(let* ((jibaku (random 26))
       (key (char-to-string (+ ?a jibaku))))
  (define-key novo-mode-map key 'novo-jibaku))

;; define interactive mode
(defun novo-mode ()
  "novo mode!!"
  (interactive)
  (setq major-mode 'novo-mode
        mode-name "novo mode dayo")
  (use-local-map novo-mode-map))

(defun novo-i-am ()
  "function that display description"
  (interactive)
  (insert (format "I am Novo![%s]" (this-command-keys))))

(defun novo-jibaku ()
  "self bomb"
  (interactive)
  (let ((visible-bell t))
    (ding)
    (sleep-for 1)
    (ding)
    (sleep-for 1)
    (ding)
    (sleep-for 1)
    (ding)
    (erase-buffer)
    (message "bomb")))
           
