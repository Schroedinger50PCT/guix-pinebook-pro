;; -*- lexical-binding: t -*-
(add-to-list 'load-path "~/.guix-profile/share/emacs/site-lisp")
(guix-emacs-autoload-packages)

;; (global-set-key (kbd "C-c -")
;;                 (lambda ()
;;                   (interactive)
;;                   (shell-command (pactl set-sink-volume @DEFAULT_SINK@ -1%))))
;; (global-set-key (kbd "C-c =")
;;                 (lambda ()
;;                   (interactive)
;;                   (shell-command (pactl set-sink-volume @DEFAULT_SINK@ +1%))))

					  
					
					;pactl set-sink-mute @DEFAULT_SINK@ toggle
					;brightnessctl set 1%- 
					;brightnessctl set +1%
					;wget https://ddl.amalgam-fansubs.moe/content/Conan/1080p/%5BTotto%5DDetektivConan-1031-RFCT-%5B1080p%5D.mp4?download
					;yt-dlp https://www.youtube.com/watch?v=trgwlkHY44A -f bestaudio -o - | ffplay - -nodisp -autoexit -loglevel quiet
					;ffmpeg -f kmsgrab -i - -filter_complex 'hwmap=derive_device=vaapi,hwdownload,format=bgr0' out.mkv


;; (defalias 'async-shell-command 'dtached-shell-command)
;; (defalias 'shell-command 'dtached-shell-command)



(require 'org-tempo)

(setq initial-major-mode 'org-mode
      make-backup-files nil
      default-directory "~/"
      warning-minimum-level :emergency
      ring-bell-function 'ignore
      tool-bar-mode nil
      tooltip-mode nil
      font-lock-maximum-decoration t
      blink-cursor-mode t
      overflow-newline-into-fringe t
					;show-paren-mode t
					;display-battery-mode t
					;display-time-mode t
					;electric-pair-mode t
      global-hl-line-mode t
      ido-enable-flex-matching t
      icomplete-separator "\n"
      icomplete-hide-common-prefix nil
      icomplete-in-buffer t
      ido-default-file-method 'selected-window
      ido-default-buffer-method 'selected-window
      icomplete-matches-format nil)

(require 'ido)
(ido-mode 1)
(setf (nth 2 ido-decorations) "\n")
       
(require 'icomplete)
(icomplete-mode 1)
(fido-vertical-mode 1)


(require 'exwm)
(require 'exwm-config)
(exwm-config-example)


(set-variable (quote scheme-program-name) "guile")

(setq-default message-log-max nil
 	      cursor-type 'hbar
 	      mode-line-format nil)

(customize-set-variable
 'display-buffer-base-action
 '((display-buffer-reuse-window display-buffer-same-window
    display-buffer-in-previous-window
    display-buffer-use-some-window)))

;(require 'all-the-icons)      
;; (require 'all-the-icons-dired)
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; (all-the-icons-dired-mode 1)
(setq doc-view-resolution 240)
(setq flyspell-issue-message-flag nil)
 


(let ((ligatures `((?-  . ,(regexp-opt '("-|" "-~" "---" "-<<" "-<" "--" "->" "->>" "-->")))
                   (?/  . ,(regexp-opt '("/**" "/*" "///" "/=" "/==" "/>" "//")))
                   (?*  . ,(regexp-opt '("*>" "***" "*/")))
                   (?<  . ,(regexp-opt '("<-" "<<-" "<=>" "<=" "<|" "<||" "<|||::=" "<|>" "<:" "<>" "<-<"
                                         "<<<" "<==" "<<=" "<=<" "<==>" "<-|" "<<" "<~>" "<=|" "<~~" "<~"
                                         "<$>" "<$" "<+>" "<+" "</>" "</" "<*" "<*>" "<->" "<!--")))
                   (?:  . ,(regexp-opt '(":>" ":<" ":::" "::" ":?" ":?>" ":=")))
                   (?=  . ,(regexp-opt '("=>>" "==>" "=/=" "=!=" "=>" "===" "=:=" "==")))
                   (?!  . ,(regexp-opt '("!==" "!!" "!=")))
                   (?>  . ,(regexp-opt '(">]" ">:" ">>-" ">>=" ">=>" ">>>" ">-" ">=")))
                   (?&  . ,(regexp-opt '("&&&" "&&")))
                   (?|  . ,(regexp-opt '("|||>" "||>" "|>" "|]" "|}" "|=>" "|->" "|=" "||-" "|-" "||=" "||")))
                   (?.  . ,(regexp-opt '(".." ".?" ".=" ".-" "..<" "...")))
                   (?+  . ,(regexp-opt '("+++" "+>" "++")))
                   (?\[ . ,(regexp-opt '("[||]" "[<" "[|")))
                   (?\{ . ,(regexp-opt '("{|")))
                   (?\? . ,(regexp-opt '("??" "?." "?=" "?:")))
                   (?#  . ,(regexp-opt '("####" "###" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" "##")))
                   (?\; . ,(regexp-opt '(";;")))
                   (?_  . ,(regexp-opt '("_|_" "__")))
                   (?\\ . ,(regexp-opt '("\\" "\\/")))
                   (?~  . ,(regexp-opt '("~~" "~~>" "~>" "~=" "~-" "~@")))
                   (?$  . ,(regexp-opt '("$>")))
                   (?^  . ,(regexp-opt '("^=")))
                   (?\] . ,(regexp-opt '("]#"))))))
  (dolist (char-regexp ligatures)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))



;; (add-hook 'org-mode-hook (lambda () "beautify org mode"
;;  			   (push '("[ ]" . "☐") prettify-symbols-alist)
;; 			   (push '("[X]" . "☑") prettify-symbols-alist)
;; 			   (push '("[-]" . "") prettify-symbols-alist)
;; 			   (push '("#+author:" . "") prettify-symbols-alist)
;; 			   (push '("#+begin_src:" . "") prettify-symbols-alist)
;; 			   (push '("#+end_src:" . "") prettify-symbols-alist)
;; 			   (prettify-symbols-mode)))

(require 'org)
(setq org-export-with-broken-links t
      org-pretty-entities t
      org-pretty-entities-include-sub-superscripts t
      org-startup-indented t
      org-startup-with-inline-images t
      org-image-actual-width '(300)
      org-src-tab-acts-natively t
      ;org-enable-notifications t
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

(setq dired-guess-shell-alist-user
      '(("\\.\\(?:xcf\\)\\'" "gimp")
        ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|ogv\\|webm\\|mp3\\|flac\\|opus\\|ogg\\)\\(?:\\.part\\)?\\'" "mpv")))

;(setq dired-du-size-format "with thousands comma separator") 


(load-theme 'soot t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("297f4cc4fc1b2ee98287edf8c61804c12d8855d782e843330d448f4ebab0474e" "7b78179a44bf44b65a0e86f6bed7e893441972c7d70558fd2375d6b61a3cf811" "9096b5a82bde4ba8a327040a97d5efee124b60c540633d643acc6e2c47666dd2" "18d0a1040f76bde6c43d27bc5a9240f9a19d0b7a15003a68a1aa3543d51a99fb" "356ee488297e3ba29a29e5aff529729ed6589ca061943c1f1819ba1a73b668db" "166ba35808bb602c2cce6163bd6c459ad72eb036ded62969ee0693926ffeb8f8" "86b43a48cfc6f379d8b946fa95b32b90334c5f03de41ba8278e2b2f668d97dc1" "6d1064c2e2753e756514542954d4cfa4cb3c257a4c2a3b7a535bf3860a01f404" default))
 '(display-buffer-base-action
   '((display-buffer-reuse-window display-buffer-same-window display-buffer-in-previous-window display-buffer-use-some-window)))
 '(global-display-line-numbers-mode nil)
;; '(package-selected-packages
;;   '(kiwix which-key dtache simple-httpd memoize all-the-icons dired-du selectrum hydra ivy company prescient htmlize async magit pg finalize emacsql-sqlite3 org-roam deferred kv matrix-client elpher))
 '(safe-local-variable-values
   '((org-roam-db-location . "~/librefine/librefine.db")
     (org-roam-directory . "~/librefine/"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
