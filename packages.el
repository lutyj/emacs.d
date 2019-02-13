(when (getenv "WORK_COMPUTER")
  (setq url-proxy-services
        '(("http" . "127.0.0.1:3128")
          ("https" . "127.0.0.1:3128"))))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package counsel
  :ensure t
  :bind ("M-y" . counsel-yank-pop))
;; :map ivy-minibuffer-map
;; ("M-y" . ivy-next-line)))

(use-package csharp-mode
  :ensure t)

(use-package csv-mode
  :ensure t
  :mode "\\.[Tt][Ss][Vv]\\'")

(use-package hydra
  :ensure t)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

; powerline leads to ediff freeze on Windows
(when (not (eq system-type 'windows-nt))
  (use-package powerline
    :ensure t
    :config (powerline-default-theme)))

(use-package swiper
  :ensure t
  :demand t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (ivy-mode +1)

  :bind (("C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("<f6>" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("<f1> f" . counsel-describe-function)
         ("<f1> v" . counsel-describe-variable)
         ("<f1> l" . counsel-find-library)
         ("<f2> i" . counsel-info-lookup-symbol)
         ("<f2> u" . counsel-unicode-char)
         :map read-expression-map
         ("C-r" . counsel-expression-history)))

(use-package vlf
  :ensure t
  :demand t
  :after hydra
  :config
  (require 'vlf-setup)
  (setq vlf-application 'dont-ask)

  (defhydra hydra-vlf (:color pink :hint nil)
    "\n
    _s_: search forward   _r_: search backward   _o_: occur
    _l_: goto line        _b_: goto batch        _<_ goto beginning   _>_ goto end\n\n"
    ("s" vlf-re-search-forward)
    ("r" vlf-re-search-backward)
    ("o" vlf-occur)
    ("l" vlf-goto-line)
    ("b" vlf-jump-to-chunk)
    ("<" (progn (vlf-beginning-of-file) (beginning-of-buffer)))
    (">" (progn (vlf-end-of-file) (end-of-buffer)))
    ("q" nil "quit" :color blue))

  :bind (:map vlf-mode-map ("." . hydra-vlf/body)))

(use-package which-key
  :ensure t
  :config (which-key-mode +1))

(use-package windresize
  :ensure t)

(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))
