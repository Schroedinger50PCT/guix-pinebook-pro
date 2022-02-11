(server-start)
(menu-bar-mode -1)                             ; No menubar
(tool-bar-mode -1) 
(scroll-bar-mode -1)
(setq inhibit-startup-message t)               ; No message at startup
(setq initial-scratch-message "")
(setq visible-bell t)                          ; No beep when reporting errors
(setq dired-use-ls-dired nil)
(global-hl-line-mode t)                        ; Highlight cursor line
(global-display-line-numbers-mode)
(add-to-list 'default-frame-alist '(font . "iosevka"))
(defalias 'yes-or-no-p 'y-or-n-p) 
(global-prettify-symbols-mode 1)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(display-time-mode 1)
(setq display-time-format "%H:%M")
(display-battery-mode 1)
