(define-derived-mode my-java-mode malabar-mode "my-java-mode"
  "customize malabar-mode."
  (define-key malabar-mode-map (kbd "C-c d") 'show-jdk))

(defvar my-jdk-sources "~/jdk1.6.0_33/src")
(defun show-jdk ()
  (interactive)
  (let (word start end result)
    (skip-chars-backward "^\n\t.;{} ")
    (setq start (point))
    (skip-chars-forward "^\n\t.;{} ")
    (setq end (point))
    (setq word (buffer-substring start end))
    (setq word (concat "class " word))
    (setq result (moccur-grep-find my-jdk-sources (list word))))
  )
