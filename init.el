;; -*- lexical-binding: t; -*-

;; Emacs Initial Configuration
;; ===========================

;; relax garbage collection
(setq gc-cons-threshold 51200000)

;; disable the toolbar
(tool-bar-mode -1)

;; set general font size
; (set-face-attribute 'defualt nil :height 100) ; for 1920 x 1080
(set-face-attribute 'default nil :height 120) ; for 2560 x 1440

;; enable Common Lisp features
(require 'cl-lib)
(require 'cl-extra)

;; add MELPA and nongnu package servers
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; if not installed, install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; (use-package sqlite3)

;; load org and my full config file
(use-package org
  :pin    gnu)

(require 'org)

(setq native-comp-debug 1)
(setq native-comp-speed 3)

(org-babel-load-file "~/.emacs.d/config.org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eglot-code-action-indications '(margin))
 '(flycheck-checker-error-threshold 500)
 '(ispell-complete-word-dict "/usr/share/dict/web2")
 '(lsp-ui-doc-show-with-cursor t)
 '(max-lisp-eval-depth 800)
 '(org-agenda-files '("/home/matthew/org/notes.org"))
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((eglot-booster :vc-backend Git :url
                    "https://github.com/jdtsmith/eglot-booster")))
 '(treesit-font-lock-level 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :foreground "yellow" :weight semi-bold :slant normal :underline nil :height 4.0))))
 '(bold ((t (:weight bold))))
 '(eglot-semantic-declaration ((t (:foreground "navajo white"))))
 '(eglot-semantic-function ((t (:foreground "khaki1"))))
 '(eglot-semantic-method ((t (:foreground "LightPink1"))))
 '(eglot-semantic-number ((t (:inherit font-lock-number-face))))
 '(eglot-semantic-operator ((t (:foreground "plum1"))))
 '(font-lock-comment-face ((t (:background "#191a21" :foreground "MistyRose4" :slant italic))))
 '(font-lock-number-face ((t (:foreground "violet"))))
 '(font-lock-operator-face ((t (:foreground "white smoke" :weight bold))))
 '(gnus-group-news-low ((t (:weight bold))))
 '(gnus-group-news-low-empty ((t (:weight normal))))
 '(markdown-code-face ((t (:extend t :background "gray15"))))
 '(org-done ((t (:inherit org-headline-done :weight bold))))
 '(org-table ((t (:foreground "gray"))))
 '(org-todo ((t (:foreground "#79D836" :weight bold)))))
