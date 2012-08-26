;; normal method
(defun normal-function (a b)
  (message (concat a " " b)))

;; interactive function
(defun interactive-function (a b)
  (interactive "sInput string a:\nsInput second b:")
  (normal-function a b))

;; display lambda
(symbol-function 'normal-function)

;; define var
(set 'foo "novo!!")
'foo
foo
(setq bar "novo!!!")
'bar
bar

;; defvar
(defvar gar "It is def var")
gar
(defvar gar "Not change!!")
gar
(defvar gar "M-C-x re-change!!!")
gar

;; let statement
(let ((make-backup-files t) write-file-fooks)
  (save-buffer))

(setq hoo "hills")
(let((hoo "not read!! preceding global variable!!") (hoo2 hoo))
  hoo2)
(let* ((hoo "yes readable!!")(hoo2 hoo))
  hoo2)

;; control function
(let ((x 1) (y 2) (z 3))
  (if (eq x 1)
      (message "x=1")
    (message "x not 1"))
  (if (and (eq x 1) (eq y 2))
      (message "x=1 and y=2")
    (message "fail..."))
  (if (or (eq x 1) (eq y 3))
      (message "x=1 or y=3")
    (message "fail..."))
  (if (not (eq z 5))
      (message "z not 5")
    (message "fail..."))          
)

(defun echo100 ()
  100)
(let ((x 5))
  (cond
   ((eq x 10) (message "x=10"))
   ((eq x 50) (message "x=50"))
   ((lambda() 200)(message "x=200"))
   ((echo100) (message "x=100"))
   (t (message "fail..."))
   ))

(let ((i ?a))
      (while (<= i ?z)
        (insert i)
        (setq i (1+ i))))

(defun func-progn(x)
  (interactive "ninput number:\n")
  (if (<= x 100)
      (progn (message "x greater than 100")
             (insert "x greater than 100!!"))
    (message "fail...")))

;; catch throw
(let ((counter 1))
  (defun check-line()
    (setq counter (1+ counter)))
  (if (catch 'found
        (while (not(eq counter 100))
          (if (eq (check-line) 10)
              (throw 'found t))))
      (message "found")
    (message "not found")))

;; unwind-protect
(let ((cb (current-buffer)))
  (unwind-protect (progn
                    (find-file "~/.emacs")
                    (sit-for 1))
    (kill-buffer (current-buffer))
    (switch-to-buffer cb)))

