;; (add-to-list 'load-path "~/.emacs.d/elisp") 

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "elisp" "conf" "public_repos")

(add-to-list 'exec-path "~/apache-maven-3.0.4/bin")

;; ELPA
;; (install-elisp "http://bit.ly/pkg-el23")
(when (require 'package nil t)       
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))


;; auto-install
(when (require 'auto-install nil t)
  ;; install directory
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))

;; emacs settings
(size-indication-mode t)
(display-time-mode t)
(display-battery-mode t)
(setq frame-title-format "%f %& %Z")
(global-linum-mode t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(set-face-attribute 'default nil
					:family "Lucida Console"
					:height 110)
(global-hl-line-mode 0)
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
;;(show-paren-match-face nil)

;; backup direcotry
(setq backup-directory-balist
      (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;; key bindings
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)
(global-set-key (kbd "C-t") 'other-window)

;; redo setting url: http://www.emacswiki.org/emacs/download/redo+.el
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo))

;; anything (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   anything-idle-delay 0.3
   anything-input-idle-delay 0.2
   anything-candidate-number-limit 100
   anything-quick-update t
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    (setq anything-su-orsudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    (descbinds-anything-install)) 
  (global-set-key (kbd "M-y") 'anything-show-kill-ring))

;; color-moccur
(when  (require 'color-moccur nil t)
  (global-set-key (kbd "M-o") 'occur-by-moccur)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;; anything-c-moccur
;; svn co http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk anything-c-moccur
;; required http://www.bookshelf.jp/elc/color-moccur.el
(when (require 'anything-c-moccur nil t)
  (setq
   anything-c-moccur-anything-idle-delay 0.1
   anything-c-moccur-higligt-info-line-flag t
   anything-c-moccur-enable-auto-look-flag t
   anything-c-moccur-enable-initial-pattern t)
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur)
  )

;; auto-complete
;;(package-install 'auto-complete)
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
               "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-\\") 'auto-complete)
  (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
  (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
  (ac-config-default))

;; moccur-edit
;;(auto-install-from-emacswiki "moccur-edit.el")
(require 'moccur-edit nil t)

;; wgrep
;;(package-install 'wgrep)
(require 'wgrep nil t)

;;undohist
;;(install-elisp "http://cx4a.org/pub/undohist.el")
(when (require 'undohist nil t)
  (undohist-initialize))

;;point-undo
;;(auto-install-from-emacswiki "point-undo.el")
(when (require 'point-undo nil t)
  (global-set-key (kbd "M-[") 'point-undo)
  (global-set-key (kbd "M-]") 'point-redo))

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; ruby minor mode
;;(install-elisp "https://raw.github.com/ruby/ruby/trunk/misc/ruby-electric.el")
;;(install-elisp "https://raw.github.com/ruby/ruby/trunk/misc/inf-ruby.el")
;;(auto-install-from-emacswiki "ruby-block.el")
(require 'ruby-electric nil t)
(when (require 'ruby-block nil t)
  (setq ruby-block-highlight-toggle t))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

(defun ruby-mode-hooks ()
  (inf-ruby-keys)
  (ruby-electric-mode t)
  (ruby-block-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)

;;;;  flymake for ruby
(require 'flymake)
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")
;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)


(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (not (null buffer-file-name)) (flymake-mode))))

(add-hook
 'ruby-mode-hook
 '(lambda ()
    (define-key ruby-mode-map "\C-cd" 'flymake-display-err-menu-for-current-line)))


;; java flymake ;; I don't want to use ant...
;;(require 'flymake)
;;(defun flymake-java-init ()
;;  (flymake-simple-make-init-impl
;;   'flymake-create-temp-with-folder-structure nil nil
;;   buffer-file-name
;;   'flymake-get-java-cmdline))
;;(defun flymake-get-java-cmdline (source base-dir)
;;  (list "javac" (list "-J-Dfile.encoding=utf-8" "-encoding" "utf-8"
;;              source)))
;;(push '("\\.java$" flymake-java-init) flymake-allowed-file-name-masks)
;;(add-hook 'java-mode-hook '(lambda () (flymake-mode t)))

;; CEDET
;; wget http://sourceforge.net/projects/cedet/files/cedet/cedet-1.1.tar.gz
;; tar -xvf cedet-1.1.tar.gz
;; emacs -Q -l cedet-build.el -f cedet-build
;; (load-file "~/.emacs.d/elisp/cedet-1.1/common/cedet.el")
(require 'cedet)
;; (semantic-load-enable-code-helpers) for cedet1.1
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))
(semantic-mode 1)

;; malabar-mode
;; git clone git://github.com/espenhw/malabar-mode.git
;; cd malabar-mode
;; mvn packge -DskipTests=true ;;because test failed...
;; unzip malabar-1.5-SNAPSHOT-dist.zip
(add-to-list 'load-path "~/emacs.d/elisp/malabar-mode")
(require 'malabar-mode)
;;(setq malabar-groovy-lib-dir "/usr/local/lib/")
(setq malabar-groovy-lib-dir "~/projects/malabar")

;; (setq malabar-groovy-compile-server-port 9500)
;; (setq malabar-groovy-eval-server-port 9501)
;; (setq malabar-groovy-extra-classpath "/home/kudoh/projects/malabar-lib")
(setq debug-on-error t)
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
(add-hook 'malabar-mode-hook
          (lambda () 
            (add-hook 'after-save-hook 'malabar-compile-file-silently
                      nil t)))
(global-set-key (kbd "C-c j") 'malabar-jump-to-thing)

;; gtags
;; wget http://tamacom.com/global/global-6.1.tar.gz
;; sudo apt-get install ncurse*
;; ./configure
;; make
;; sudo make intall
(require 'gtags nil t)
(setq gtags-suggested-key-mapping nil)
(global-set-key (kbd "C-c t") 'gtags-find-tag)
(global-set-key (kbd "C-c e") 'gtags-pop-stack)

;; multi-term
;; (package-install 'multi-term)
(when (require 'multi-term nil t)
  (setq multi-term-program "/bin/bash"))

;; yasnippet
;; git clone https://github.com/capitaomorte/yasnippet

(when (require 'yasnippet)
  (yas/global-mode 1)
  (yas/load-directory "~/.emacs.d/public_repos/yasnippet/snippets"))

;; java auto complete
;; git clone https://github.com/jixiuf/ajc-java-complete
;; cp -p popup-patch.diff ~/.emacs.d/elpa/auto-complete-1.4/
;; patch -p0 < popup-patch.diff -> not done because auto-complete is 1.4...
;; javac Tags.java
;; export CLASSPATH=$JAVA_HOME:/path/to/jars/:/project/WEB-INF/classes/:.
;; java Tags -XX:MaxPermSize=512m
;; didn't use...
;;(when (require 'ajc-java-complete-config)
;;  (add-hook 'java-mode-hook 'ajc-java-complete-mode)
;;  (add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook))
(put 'erase-buffer 'disabled nil)
