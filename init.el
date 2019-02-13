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
(display-time-mode +1)

(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)
(setq inhibit-startup-screen t)
(setq line-number-display-limit-width 2000000)
(setq ring-bell-function 'ignore)

(setq-default indent-tabs-mode nil) ; Use spaces for indentation
(setq-default tab-width 4)
(setq backward-delete-char-untabify-method nil)
(setq c-default-style "java")

(require 'dired)
;; (setq wdired-allow-to-change-permissions t)
(setq dired-dwim-target t)             ; Set default copy/move target in 'two panel' dired layout
(setq dired-recursive-deletes 'always) ; No additional confirmations when deleting directories
(define-key dired-mode-map "t" nil)    ; Disable toggling selected files with 't' key

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

(defalias 'list-buffers 'ibuffer-other-window)
(setq ibuffer-default-sorting-mode 'major-mode)
(setq ibuffer-expert t) ; Disable 'Really kill buffer?' confirmation

(require 'uniquify)

; Highlight empty/long lines, tabs, and trailing spaces in program code
(require 'whitespace)
(setq whitespace-style '(face empty tab-mark tabs lines trailing))
(setq whitespace-line-column 99)
(add-hook 'prog-mode-hook 'whitespace-mode)

(windmove-default-keybindings 'meta)

(winner-mode +1)

; Use PostgreSQL syntax by default
(add-hook 'sql-mode-hook (lambda () (sql-set-product 'postgres)))

; Move the point to the farthest position when no more scrolling is possible
(setq scroll-error-top-bottom t)

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times.
This command does NOT push text to `kill-ring'."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times.
This command does NOT push text to `kill-ring'."
  (interactive "p")
  (delete-word (- arg)))

(global-set-key (kbd "M-d") 'delete-word)
(global-set-key (kbd "<M-backspace>") 'backward-delete-word)

; Speed up emacs on buffers with a lot of unicode
(setq inhibit-compacting-font-caches t)

; By default Emacs will initiate GC every 0.76 MB allocated (gc-cons-threshold = 800000)
; Increasing this value can lead to a better speed/memory tradeoff
;; (setq gc-cons-threshold 20000000)

;; (add-hook 'dired-mode-hook 'auto-revert-mode)
(global-auto-revert-mode +1)
(setq auto-revert-verbose nil) ; Disable 'Reverting buffer' message

;; (desktop-save-mode +1)
(savehist-mode +1)

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq custom-file (concat user-emacs-directory ".custom.el"))

(setq default-input-method 'russian-computer)

(fset 'yes-or-no-p 'y-or-n-p)

(load (concat user-emacs-directory "packages.el"))

(when (eq system-type 'windows-nt)
  (setq ls-lisp-dirs-first t)
  (setq ls-lisp-UCA-like-collation nil)
  (setq find-program "gfind")
  (setq tramp-default-method "plink")
  (setq python-check-command "C:/Anaconda2/Scripts/pyflakes.exe"))
