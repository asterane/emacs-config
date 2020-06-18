;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/notes.org")))
 '(package-selected-packages (quote (org-mime amx ido-completing-read+ magit)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(require 'cl)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(define-key key-translation-map (kbd "C-x") (kbd "C-u"))
(define-key key-translation-map (kbd "C-u") (kbd "C-x"))

(define-key key-translation-map (kbd "C-p") (kbd "C-t"))
(define-key key-translation-map (kbd "C-t") (kbd "C-p"))

(define-key key-translation-map (kbd "M-x") (kbd "M-u"))
(define-key key-translation-map (kbd "M-u") (kbd "M-x"))

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

(global-set-key (kbd "C-c e") 'enlarge-window)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(setq org-catch-invisible-edits 'smart)

(setq ido-enable-flex-matching t)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)
(amx-mode 1)

(defun kill-region-or-backward-kill-word (&optional arg region)
  "'kill-region' if the region is active, otherwise 'backward-kill-word'"
  (interactive
   (list (prefix-numeric-value current-prefix-arg) (use-region-p)))
  (if region
      (kill-region (region-beginning) (region-end))
    (backward-kill-word arg)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;MU4E CONFIG
;;===========
(require 'org-mime)

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")
(require 'mu4e)

(setq mu4e-maildir (expand-file-name "~/Maildir"))

; get mail
(setq mu4e-get-mail-command "mbsync -c ~/.emacs.d/mu4e/.mbsyncrc -a"
  ;; mu4e-html2text-command "w3m -T text/html" ;;using the default mu4e-shr2text
  mu4e-view-prefer-html t
  mu4e-update-interval 180
  mu4e-headers-auto-update t
  mu4e-compose-signature-auto-include nil
  mu4e-compose-format-flowed t)

;; to view selected message in the browser, no signin, just html mail
(add-to-list 'mu4e-view-actions
  '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; every new email composition gets its own frame!
;(setq mu4e-compose-in-new-frame t)

;; don't save message to Sent Messages, IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

(add-hook 'mu4e-view-mode-hook #'visual-line-mode)

;; <tab> to navigate to links, <RET> to open them in browser
(add-hook 'mu4e-view-mode-hook
  (lambda()
;; try to emulate some of the eww key-bindings
(local-set-key (kbd "<RET>") 'mu4e~view-browse-url-from-binding)
(local-set-key (kbd "<tab>") 'shr-next-link)
(local-set-key (kbd "<backtab>") 'shr-previous-link)))

;; from https://www.reddit.com/r/emacs/comments/bfsck6/mu4e_for_dummies/elgoumx
(add-hook 'mu4e-headers-mode-hook
      (defun my/mu4e-change-headers ()
    (interactive)
    (setq mu4e-headers-fields
          `((:human-date . 25) ;; alternatively, use :date
        (:flags . 6)
        (:from . 22)
        (:thread-subject . ,(- (window-body-width) 70)) ;; alternatively, use :subject
        (:size . 7)))))

;; if you use date instead of human-date in the above, use this setting
;; give me ISO(ish) format date-time stamps in the header list
(setq mu4e-headers-date-format "%Y-%m-%d %H:%M")

;; spell check
(add-hook 'mu4e-compose-mode-hook
    (defun my-do-compose-stuff ()
       "My settings for message composition."
       (visual-line-mode)
       (org-mu4e-compose-org-mode)
           (use-hard-newlines -1)
       (flyspell-mode)))

(require 'smtpmail)

;;rename files when moving
;;NEEDED FOR MBSYNC
(setq mu4e-change-filenames-when-moving t)

;;set up queue for offline email
;;use mu mkdir  ~/Maildir/acc/queue to set up first
(setq smtpmail-queue-mail nil)  ;; start in normal mode

;;from the info manual
(setq mu4e-attachment-dir  "~/Downloads")

(setq message-kill-buffer-on-exit t)
(setq mu4e-compose-dont-reply-to-self t)

(require 'org-mu4e)

;; convert org mode to HTML automatically
(setq org-mu4e-convert-to-html t)

;;from vxlabs config
;; show full addresses in view message (instead of just names)
;; toggle per name with M-RET
(setq mu4e-view-show-addresses 't)

;; don't ask when quitting
(setq mu4e-confirm-quit nil)

;; mu4e-context
(setq mu4e-context-policy 'pick-first)
(setq mu4e-compose-context-policy 'always-ask)
(setq mu4e-contexts
  (list
   (make-mu4e-context
    :name "main" ;;for example-gmail
    :enter-func (lambda () (mu4e-message "Entering context main"))
    :leave-func (lambda () (mu4e-message "Leaving context main"))
    :match-func (lambda (msg)
          (when msg
        (mu4e-message-contact-field-matches
         msg '(:from :to :cc :bcc) "example@gmail.com")))
    :vars '((user-mail-address . "example@gmail.com")
        (user-full-name . "Matthew Rothlisberger")
        (mu4e-sent-folder . "/example-gmail/[example].Sent Mail")
        (mu4e-drafts-folder . "/example-gmail/[example].drafts")
        (mu4e-trash-folder . "/example-gmail/[example].Trash")
        (mu4e-compose-signature . (concat "Matthew Rothlisberger\n" "\n"))
        (mu4e-compose-format-flowed . t)
        (smtpmail-queue-dir . "~/Maildir/example-gmail/queue/cur")
        (message-send-mail-function . smtpmail-send-it)
        (smtpmail-smtp-user . "example")
        (smtpmail-starttls-credentials . (("smtp.gmail.com" 587 nil nil)))
        (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
        (smtpmail-default-smtp-server . "smtp.gmail.com")
        (smtpmail-smtp-server . "smtp.gmail.com")
        (smtpmail-smtp-service . 587)
        (smtpmail-debug-info . t)
        (smtpmail-debug-verbose . t)
        (mu4e-maildir-shortcuts . ( ("/example-gmail/INBOX"            . ?i)
                    ("/example-gmail/[example].Sent Mail" . ?s)
                    ("/example-gmail/[example].Trash"       . ?t)
                    ("/example-gmail/[example].All Mail"  . ?a)
                    ("/example-gmail/[example].Starred"   . ?r)
                    ("/example-gmail/[example].drafts"    . ?d)
                    ))))))
;;===
;;END
   
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 5
      )

(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default electric-pair-mode t)

(eldoc-mode 1)
(define-key emacs-lisp-mode-map
  (kbd "M-.") 'find-function-at-point)

(electric-pair-mode)
(setq-default electric-pair-delete-adjacent-pairs t)
(setq-default electric-pair-preserve-balance t)

(defun my-tab-width ()
  "Cycle tab width between values 2, 4, and 8."
  (interactive)
  (setq tab-width
        (cond ((eq tab-width 8) 2)
              ((eq tab-width 2) 4)
              (t 8)))
  (redraw-display))

(global-set-key (kbd "C-c t") 'my-tab-width)

(c-add-style "my-style"
             '("gnu"
               (c-basic-offset . 4)     ; Guessed value
               (c-offsets-alist
                (block-close . 0)       ; Guessed value
                (defun-block-intro . +) ; Guessed value
                (defun-close . 0)       ; Guessed value
                (defun-open . 0)        ; Guessed value
                (statement . 0)             ; Guessed value
                (statement-block-intro . +) ; Guessed value
                (substatement . +)      ; Guessed value
                (substatement-open . 0) ; Guessed value
                (topmost-intro . 0)     ; Guessed value
                (access-label . -)
                (annotation-top-cont . 0)
                (annotation-var-cont . +)
                (arglist-close . c-lineup-close-paren)
                (arglist-cont c-lineup-gcc-asm-reg 0)
                (arglist-cont-nonempty . c-lineup-arglist)
                (arglist-intro . c-lineup-arglist-intro-after-paren)
                (block-open . 0)
                (brace-entry-open . 0)
                (brace-list-close . 0)
                (brace-list-entry . c-lineup-under-anchor)
                (brace-list-intro . c-lineup-arglist-intro-after-paren)
                (brace-list-open . +)
                (c . c-lineup-C-comments)
                (case-label . 0)
                (catch-clause . 0)
                (class-close . 0)
                (class-open . 0)
                (comment-intro . c-lineup-comment)
                (composition-close . 0)
                (composition-open . 0)
                (cpp-define-intro c-lineup-cpp-define +)
                (cpp-macro . -1000)
                (cpp-macro-cont . +)
                (do-while-closure . 0)
                (else-clause . 0)
                (extern-lang-close . 0)
                (extern-lang-open . 0)
                (friend . 0)
                (func-decl-cont . +)
                (inclass . +)
                (incomposition . +)
                (inexpr-class . +)
                (inexpr-statement . +)
                (inextern-lang . +)
                (inher-cont . c-lineup-multi-inher)
                (inher-intro . +)
                (inlambda . c-lineup-inexpr-block)
                (inline-close . 0)
                (inline-open . 0)
                (inmodule . +)
                (innamespace . +)
                (knr-argdecl . 0)
                (knr-argdecl-intro . 5)
                (label . 0)
                (lambda-intro-cont . +)
                (member-init-cont . c-lineup-multi-inher)
                (member-init-intro . +)
                (module-close . 0)
                (module-open . 0)
                (namespace-close . 0)
                (namespace-open . 0)
                (objc-method-args-cont . c-lineup-ObjC-method-args)
                (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
                (objc-method-intro .
                                   [0])
                (statement-case-intro . +)
                (statement-case-open . +)
                (statement-cont . +)
                (stream-op . c-lineup-streamop)
                (string . -1000)
                (substatement-label . 0)
                (template-args-cont c-lineup-template-args +)
                (topmost-intro-cont first c-lineup-topmost-intro-cont c-lineup-gnu-DEFUN-intro-cont))))

(setq c-default-style "my-style")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
