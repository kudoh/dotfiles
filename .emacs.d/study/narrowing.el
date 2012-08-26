(defun my-narrowing-test ()
  (interactive)
  (goto-char (point-min))
  (save-restriction
    (save-excursion
      (search-forward "--end")
      (goto-char (match-beginning 0))
      (narrow-to-region
       (point-min) (point))
      (message "end is %d" (point))
      (sit-for 3))
    (while (not (eobp))
      (insert "Test!!")
      (forward-line 1))))
      




















