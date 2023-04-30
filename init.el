;; Emacs Initial Configuration
;; ===========================

;; disable the toolbar
(tool-bar-mode -1)

;; get font size back to normal under dwm
(set-face-attribute 'default nil :height 93)

;; enable Common Lisp features
(require 'cl)

;; add MELPA package server
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; if not installed, install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(use-package sqlite3)

;; load org and my full config file
(use-package org
  :pin    gnu
  :ensure org-plus-contrib)

(require 'org)

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
 '(flycheck-checker-error-threshold 500)
 '(lsp-ui-doc-show-with-cursor t)
 '(org-agenda-files '("~/org/notes.org" "~/.notes"))
 '(package-selected-packages
   '(sqlite3 markdown-mode magit-section lsp-ui lsp-mode eldoc org glsl-mode browse-kill-ring projectile forge speed-type ox-hugo deadgrep lua-mode company flycheck all-the-icons-dired doom-modeline doom-themes all-the-icons auto-package-update use-package unfill org-plus-contrib org-mime magit ido-completing-read+ amx)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
