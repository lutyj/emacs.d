(when (getenv "WORK_COMPUTER")
  (customize-set-variable 'url-proxy-services
                          '(("http" . "192.168.56.1:3128")
                            ("https" . "192.168.56.1:3128"))))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package ace-window
  :ensure t
  :config (set-face-attribute 'aw-leading-char-face nil :height 2.0)
  :bind ("M-o" . ace-window))

(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package counsel
  :ensure t
  :config (counsel-mode +1))

(use-package csharp-mode
  :ensure t)

(use-package csv-mode
  :ensure t
  :mode "\\.[Tt][Ss][Vv]\\'")

(use-package hydra
  :ensure t
  :config
  (defhydra hydra-buffer-encoding (:color pink :hint nil)
    "\n
    _u_: utf-8   _1_: cp1251   _8_: cp866\n\n"
    ("u" (revert-buffer-with-coding-system 'utf-8) :exit t)
    ("1" (revert-buffer-with-coding-system 'cp1251) :exit t)
    ("8" (revert-buffer-with-coding-system 'cp866) :exit t)
    ("q" nil "quit" :color blue))

  :bind ("C-c e" . hydra-buffer-encoding/body))

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
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode +1)

  :bind (("C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("<f6>" . ivy-resume)))

(use-package vlf
  :ensure t
  :demand t
  :after hydra
  :custom
  (vlf-application 'dont-ask)
  :config
  (require 'vlf-setup)

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
