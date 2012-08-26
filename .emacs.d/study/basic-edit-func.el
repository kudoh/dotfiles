
(defun my-calculator ()
  (interactive)
  (save-excursion
    (let ((sum 0) n)
      (goto-char (point-min))
      (re-search-forward "^--begin$")
      (while (re-search-forward "\\(^--end\\)\\|\\([0-9]+$\\)" nil t)
        (cond
         ((match-beginning 2)
          (setq n (match-string 2)) ;; get amount
          (setq n (string-to-number n)) ;; cast number
          (goto-char (match-beginning 2))
          (skip-chars-backward " \t")
          (delete-region
           (point)
           (progn (end-of-line) (point)))
          (move-to-column 70 t)
          (insert (format  "%5d" n))
          (setq sum (+ sum n)))
         ((match-beginning 1) ;; find end tag
          (delete-region
           (point)
           (progn (end-of-line) (point)))
          (move-to-column 70 t)
          (insert (format "%5d" sum))))))))
