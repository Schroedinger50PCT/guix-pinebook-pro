;; -*- lexical-binding: t -*-
(add-to-list 'load-path "~/.guix-profile/share/emacs/site-lisp")
(guix-emacs-autoload-packages)

;(add-to-list 'load-path "~/.emacs.d/spray")
;(require 'spray)
					;speedreading

;(require 'simple-httpd)

(defalias 'async-shell-command 'dtache-shell-command)
(defalias 'shell-command 'dtache-shell-command)
;(global-set-key 'async-shell-command 'dtache-shell-command)


(setq initial-major-mode 'org-mode
      default-directory "~/"
      warning-minimum-level :emergency
      ring-bell-function 'ignore
      tool-bar-mode nil
      tooltip-mode nil
      font-lock-maximum-decoration t
      display-battery-mode t
      display-time-mode t
      fringe-mode 0
      blink-cursor-mode t)
      ;show-paren-mode t
      ;display-battery-mode t
      ;display-time-mode t
      ;electric-pair-mode t
      



(set-variable (quote scheme-program-name) "guile")

(setq-default message-log-max nil
	      cursor-type 'hbar
	      auto-fill-function 'do-auto-fill
	      mode-line-format nil)

(customize-set-variable
 'display-buffer-base-action
 '((display-buffer-reuse-window display-buffer-same-window
    display-buffer-in-previous-window
    display-buffer-use-some-window)))


					;(set-frame-parameter (selected-frame) 'alpha '(92 . 92))
					 ;(add-to-list 'default-frame-alist '(alpha . (92 . 92)))

(setq user-full-name "Jakob Maximilian Honal"
      user-mail-address "jakob.honal@gmx.de")

(setq
 ;; The mail URL, specifying a remote mail account
 ;; (Omit this to read from /var/mail/user)
 rmail-primary-inbox-list
 '("pop://jakob.honal%40gmx.de@mail.gmx.net")

 send-mail-function 'smtpmail-send-it       ; Send mail via SMTP
 smtpmail-smtp-server "mail.gmx.com"
 smtpmail-smtp-service 25
 rmail-preserve-inbox 1                     ; Don't delete mail from server
 rmail-mail-new-frame 1                     ; Compose in a full frame
 rmail-delete-after-output 1                ; Delete original mail after copying
 rmail-mime-prefer-html nil                 ; Prefer plaintext when possible
 rmail-file-name   "~/mail/inbox"           ; The path to our inbox file
 rmail-secondary-file-directory "~/mail"    ; The path to our other mbox files
 message-default-headers "Fcc: ~/mail/sent") ; Copy sent mail to the "sent" file

(require 'all-the-icons)
(require 'all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(all-the-icons-dired-mode 1)
(setq doc-view-resolution 240)
(setq flyspell-issue-message-flag nil)
 
(require 'selectrum)
(selectrum-mode +1)
(selectrum-prescient-mode +1)
( prescient-persist-mode +1)

(add-hook 'org-mode-hook (lambda () "beautify org mode"
 			   (push '("[ ]" . "☐") prettify-symbols-alist)
			   (push '("[X]" . "☑") prettify-symbols-alist)
			   (push '("[-]" . "") prettify-symbols-alist)
			   (push '(">=" . "≥") prettify-symbols-alist)
			   (push '("<=" . "≤") prettify-symbols-alist)
			   (push '("|>" . "▷") prettify-symbols-alist)
			   (push '("<|" . "◁") prettify-symbols-alist)
			   (push '("->>" . "↠") prettify-symbols-alist)
			   (push '("->"	. "→") prettify-symbols-alist)
			   (push '("<-" . "←") prettify-symbols-alist)
			   (push '("#+author:" . "") prettify-symbols-alist)
			   (push '("#+begin_src:" . "") prettify-symbols-alist)
			   (push '("#+end_src:" . "") prettify-symbols-alist)
			   (prettify-symbols-mode)))

(require 'org)
(setq org-export-with-broken-links t
      org-pretty-entities t
      org-pretty-entities-include-sub-superscripts t
      org-startup-indented t
      org-startup-with-inline-images t
      org-image-actual-width '(300)
      org-src-tab-acts-natively t
      org-enable-notifications t
      org-start-notification-daemon-on-startup t)

(setq org-agenda-files (quote ("~/")))
(require 'shell)

(setq org-roam-directory "~/"
      org-roam-graph-executable "dot"
      org-roam-graph-viewer "emacsclient"
      org-roam-v2-ack t
      org-hide-block-startup t)

;; (setq org-roam-graph-extra-config  '(;("rankdir" . "LR")
;; 				     ("bgcolor" . "black")))
;; (setq org-roam-graph-node-extra-config '(("fillcolor" . "black")))
;; (setq org-roam-graph-edge-extra-config '(("color" . "gray")))



(require 'which-key)
(which-key-mode)

(setq dired-guess-shell-alist-user
      '(("\\.\\(?:xcf\\)\\'" "gimp")
        ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|ogv\\|webm\\|mp3\\|flac\\|opus\\|ogg\\)\\(?:\\.part\\)?\\'" "mpv")))

(setq dired-du-size-format "with thousands comma separator")


;;  '(smtpmail-smtp-server "mail.gmx.com" t)
;;  '(smtpmail-smtp-service 25 t))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6d1064c2e2753e756514542954d4cfa4cb3c257a4c2a3b7a535bf3860a01f404" default))
 '(global-display-line-numbers-mode nil)
 '(safe-local-variable-values
   '((org-roam-db-location . "~/librefine/librefine.db")
     (org-roam-directory . "~/librefine/"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
