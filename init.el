;; Emacs Initial Configuration
;; ===========================

;; disable the toolbar
(tool-bar-mode -1)

;; enable Common Lisp features
(require 'cl)

;; add MELPA package server
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; if not installed, install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; load org and the full config file
(require 'org)
(use-package org
  :ensure org-plus-contrib)

(org-babel-load-file "~/.emacs.d/config.org")

;; fix hyperbole messing with my favorite org mode keybinding
(add-hook 'org-mode-hook
          (lambda ()
            (local-unset-key (kbd "M-<RET>"))
            (local-unset-key (kbd "M-RET"))
            (define-key org-mode-map (kbd "M-RET") 'org-meta-return)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/org/notes.org" "~/.notes"))
 '(package-selected-packages
   '(glsl-mode browse-kill-ring projectile forge speed-type ox-hugo deadgrep lua-mode company flycheck all-the-icons-dired doom-modeline doom-themes all-the-icons auto-package-update use-package unfill org-plus-contrib org-mime magit ido-completing-read+ amx)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
