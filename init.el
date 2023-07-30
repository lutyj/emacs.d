(package-initialize)

(add-to-list 'default-frame-alist '(font . "Hack-10"))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode +1)
(global-hl-line-mode +1)
(electric-pair-mode +1)
(show-paren-mode +1)
(size-indication-mode +1)

(customize-set-variable 'display-time-24hr-format t)
(customize-set-variable 'display-time-default-load-average nil)
(display-time-mode +1)

(customize-set-variable 'inhibit-startup-screen t)
(customize-set-variable 'line-number-display-limit-width 2000000)
(customize-set-variable 'ring-bell-function 'ignore)

(customize-set-variable 'indent-tabs-mode nil) ; Use spaces for indentation
(customize-set-variable 'tab-width 4)
(customize-set-variable 'backward-delete-char-untabify-method nil)
(customize-set-variable 'c-default-style "java")

(require 'dired)
;; (customize-set-variable 'wdired-allow-to-change-permissions t)
(customize-set-variable 'dired-dwim-target t) ; Set default copy/move target in 'two panel' dired
(customize-set-variable 'dired-recursive-deletes 'always) ; Delete dirs without extra confirmation
(define-key dired-mode-map "t" nil) ; Disable toggling selected files with 't' key

(customize-set-variable 'ediff-window-setup-function 'ediff-setup-windows-plain)
(customize-set-variable 'ediff-split-window-function 'split-window-horizontally)

(defalias 'list-buffers 'ibuffer-other-window)
(customize-set-variable 'ibuffer-default-sorting-mode 'major-mode)
(customize-set-variable 'ibuffer-expert t) ; Disable 'Really kill buffer?' confirmation

(require 'uniquify)

; Highlight empty/long lines, tabs, and trailing spaces in program code
(require 'whitespace)
(customize-set-variable 'whitespace-style '(face empty tab-mark tabs lines trailing))
(customize-set-variable 'whitespace-line-column 99)
(add-hook 'prog-mode-hook 'whitespace-mode)

(winner-mode +1)

; Use PostgreSQL syntax by default
(add-hook 'sql-mode-hook (lambda () (sql-set-product 'postgres)))

; Move the point to the farthest position when no more scrolling is possible
(customize-set-variable 'scroll-error-top-bottom t)

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times.
This command does NOT push any text to `kill-ring'."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times.
This command does NOT push any text to `kill-ring'."
  (interactive "p")
  (delete-word (- arg)))

(global-set-key (kbd "M-d") 'delete-word)
(global-set-key (kbd "<M-backspace>") 'backward-delete-word)


; Speed up emacs on buffers with a lot of unicode
(customize-set-variable 'inhibit-compacting-font-caches t)

; By default Emacs will initiate GC every 0.76 MB allocated (gc-cons-threshold = 800000)
; Increasing this value can lead to a better speed/memory tradeoff
;; (customize-set-variable 'gc-cons-threshold 20000000)

; Disable scanning for bidirectional text (speed up on long lines)
(customize-set-variable 'bidi-display-reordering nil)

;; (add-hook 'dired-mode-hook 'auto-revert-mode)
(global-auto-revert-mode +1)
(customize-set-variable 'auto-revert-verbose nil) ; Disable 'Reverting buffer' message

;; (desktop-save-mode +1)
(savehist-mode +1)

(customize-set-variable 'auto-save-default nil)
(customize-set-variable 'make-backup-files nil)
(customize-set-variable 'custom-file (concat user-emacs-directory ".custom.el"))

(customize-set-variable 'default-input-method 'russian-computer)

(customize-set-variable 'help-window-select t)

; (customize-set-variable 'org-babel-load-languages (quote ((emacs-lisp . t) (ein . t))))

(fset 'yes-or-no-p 'y-or-n-p)

(load (concat user-emacs-directory "packages.el"))

(when (eq system-type 'windows-nt)
  (customize-set-variable 'ls-lisp-dirs-first t)
  (customize-set-variable 'ls-lisp-UCA-like-collation nil)
  (customize-set-variable 'ls-lisp-use-localized-time-format t)
  (customize-set-variable 'ls-lisp-format-time-list '("%Y-%m-%d %H:%M" "%Y-%m-%d %H:%M"))
  (customize-set-variable 'find-program "gfind")
  (customize-set-variable 'tramp-default-method "plink")
  (customize-set-variable 'python-check-command "C:/Miniconda3/Scripts/pyflakes.exe"))
