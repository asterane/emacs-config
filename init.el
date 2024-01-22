;; -*- lexical-binding: t; -*-

;; Emacs Initial Configuration
;; ===========================

;; disable the toolbar
(tool-bar-mode -1)

;; get font size back to normal under dwm
(set-face-attribute 'default nil :height 100)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-checker-error-threshold 500)
 '(lsp-ui-doc-show-with-cursor t)
 '(org-agenda-files '("~/org/notes.org" "~/.notes"))
 '(package-selected-packages
   '(hl-todo ledger-mode markdown-mode magit-section lsp-ui lsp-mode eldoc org glsl-mode browse-kill-ring forge speed-type ox-hugo deadgrep lua-mode flycheck doom-modeline doom-themes auto-package-update use-package unfill org-plus-contrib org-mime magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :foreground "yellow" :weight semi-bold :slant normal :underline nil :height 4.0))) t)
 '(bold ((t (:foreground "#D0D0D0" :weight bold))))
 '(org-done ((t (:inherit org-headline-done :weight bold))))
 '(org-table ((t (:foreground "gray"))))
 '(org-todo ((t (:foreground "#79D836" :weight bold)))))
