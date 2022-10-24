(use-modules (bribe)
	     (guix packages) (guix download) (guix licenses) (guix gexp)
	     (guix git-download) (guix build-system trivial) (gnu)
	     (gnu bootloader u-boot) (gnu system nss) (gnu packages)
	     (srfi srfi-1))


(use-service-modules audio cups dbus desktop networking mcron sound ssh xorg)
(use-package-modules aspell admin audio bash bootloaders certs curl cups
		     pulseaudio emacs emacs-xyz freedesktop gnome graphviz password-utils
		     games rsync image imagemagick matrix libusb
		     messaging maths package-management wm rsync shells 
		     shellutils scanner ssh text-editors tls
		     video version-control gimp graphics wget disk xorg xdisorg fonts)


;; (define emacs-service
;;   (make <service>
;;     #:provides '(emacs-service)
;;     #:docstring "Run the emacs daemon"
;;     #:start (make-forkexec-constructor '("emacs" "--fg-daemon"))
;;     #:stop (make-kill-destructor)
;;     #:respawn? #t))

;; (define pipewire-service
;;   (make <service>
;;     #:provides '(pipewire-service)
;;     #:docstring "Run the pipewire daemon"
;;     #:start (make-forkexec-constructor '("pipewire -c /dots/pipewire.conf"))
;;     #:stop (make-kill-destructor)
;;     #:respawn? #t))


(operating-system (kernel linux-libre-arm64-generic)
		  ;; the following procedure for an undeblobbed kernel is taken from issues.guix.gnu.org/issue/40835/attachment/0/1/0
		  ;; 
		  ;; Since I don’t have a usb wifi adapter, I cheated (until I get one) and I commented out the following in the gnu/packages/linux.scm file as follows:
		  ;; --- a/gnu/packages/linux.scm
		  ;; +++ b/gnu/packages/linux.scm
		  ;; @@ -326,8 +326,8 @@ corresponding UPSTREAM-SOURCE (an origin), using the given DEBLOB-SCRIPTS."
		  ;;                    (with-directory-excursion dir
		  ;;                      (setenv "PYTHON" (which "python"))
		  ;;                      (format #t "Running deblob script...~%")
		  ;; -                    (force-output)
		  ;; -                    (invoke "/tmp/bin/deblob"))
		  ;; +                    (force-output))
		  ;; +;;                    (invoke "/tmp/bin/deblob"))
		  ;;                    (format #t "~%Packing new Linux-libre tarball...~%")
		  ;;                    (force-output)
		  ;; Also if you do this, you need to create the following folders on the SD card:
		  ;; /lib/firmware/brcm
		  ;; /lib/firmware/rockchip
		  ;; Inside the brcm folder you need to place all the brcmfmac43456-sdio.* files
		  ;; Inside the rockchip folder you need to place pptx.bin
		  ;; I will leave it up to the reader to find and install these files, since this is not the preferred way.
		  
		  (kernel-arguments '("modprobe.blacklist=pcspkr,snd_pcsp"))
		  (initrd-modules '())
		  (firmware %base-firmware)
		  (host-name "pinebook") 
		  (timezone "Europe/Berlin")
		  (locale "en_US.utf8")
		  (keyboard-layout (keyboard-layout "us"))
                  
		  (bootloader (bootloader-configuration 
               		       (bootloader u-boot-pinebook-pro-rk3399-bootloader) 
               		       (targets '("/dev/sda"))))
                  
		  (file-systems (append (list 
					 (file-system (device  (uuid
								"4d612e97-28f2-460a-9861-5f089fe2b4d5"))
						      (mount-point "/")
					   	      (type "ext4"))) %base-file-systems))
					;(swap-devices (list "/dev/sda3"))

		  (users (append (list  
				  (user-account (name "botty") 
						(comment "Botty Mac Botface")
						(group "users") 
						(supplementary-groups '("wheel" "netdev" "audio" "video" "lp")) ;lpadmin 
						(home-directory "/home/botty")
						(password (crypt
							   "botty"
							   "3d8n7")))
				  
				  (user-account (name "root") 
						(uid 0)
						(comment "")
						(group "root")
						(password (crypt
							   "root"
							   "6h94ll"))))
				 %base-user-accounts))
		  
		  (issue "")
		  (packages (append (list alsa-lib alsa-utils acpid
					  emacs-which-key
					; libusb
					  emacs-org-roam
					  emacs
					  aspell aspell-dict-en aspell-dict-de
					; emacs-gnuplot fdisk
					  ffmpeg font-iosevka-term
					  font-tamzen
					; js-mathjax imagemagick
					  bluez bluez-alsa
					  curl
					;git
					  gpm
					; grim graphviz gnuplot
					; yt-dlp pipewire 
					; password-store rsync
					; slurp
					  kiwix-tools rtorrent
					  sway mako libnotify
					  wget 	;wxwidgets
					  wpa-supplicant ;wl-clipboard
					; xdg-utils xdg-desktop-portal
					; xdg-desktop-portal-wlr
					;inkscape
					;emacs-matrix-client
					;emacs-ox-pandoc emacs-guix
					;waypipe gimp gnucap ngspice
					  nss-certs) %base-packages))

		  (services (append (list
					;(service pipewire-service)
					;(service emacs-service)
			       	     (service gpm-service-type)
					;(service sane-service-type sane-backends) ; mit xsane oder so verwenden
				     ;; (service cups-service-type
				     ;; 	      (cups-configuration
				     ;; 	       (web-interface? #t)
				     ;; 	       (default-paper-size "A4")
				     ;; 	       (extensions (list cups-filters epson-inkjet-printer-escpr hplip-minimal))))
					;(service mpd-service-type
					;	      (mpd-configuration
					;	       (music-dir "/music")))
				     
					;    (service tor-service-type)
					;(tor-hidden-service "ssh" '((22 "127.0.0.1:22")))
					;(tor-hidden-service "guix-publish" '((3000 "127.0.0.1:3000")))
				     (service wpa-supplicant-service-type
					      (wpa-supplicant-configuration
					       (config-file "/dots/wpa_supplicant.conf")
					       (interface "wlp4s0")))
				     
				     (service dhcp-client-service-type)
				     ;; (dropbear-service (dropbear-configuration (port-number 22)
				     ;; 					       (root-login? #t)
				     ;; 					       (password-authentication? #f)))
					;(bluetooth-service #:auto-enable? #t)
				     (dbus-service)
				     (service elogind-service-type (elogind-configuration
								    (kill-user-processes? #f)
								    (handle-power-key 'poweroff)
								    (handle-suspend-key 'ignore)
								    (handle-hibernate-key 'ignore) 
								    (handle-lid-switch 'ignore) 
								    (handle-lid-switch-docked 'ignore))))
				    
				    (modify-services %base-services
						     (console-font-service-type config => (map
											   (lambda (tty) (cons tty "/run/current-system/profile/share/kbd/consolefonts/TamzenForPowerline10x20.psf"))
											   '("tty1" "tty2" "tty3" "tty4" "tty5" "tty6")))

						     (guix-service-type config => (guix-configuration
										   (inherit config)
										   ;;(authorize-key? #t)
										   ;;(authorized-keys %default-authorized-guix-keys)
										   ;;(use-substitutes? #t)
										   ;;(substitute-urls %default-substitute-urls)
										   ;;(max-silent-time 0)
										   ;;(timeout 0)
										   ;;(log-compression 'bzip2)
										   ;;(extra-options '())
										   ;;(log-file "/var/log/guix-daemon.log")
										   ;;(http-proxy #t)
	    									   (tmpdir "/build"))))))
		  (name-service-switch %mdns-host-lookup-nss))
		 
;; You need to edit the /boot/extlinux/extlinux.conf file on the SD card and alter the FDTDIR line.
;; I changed mine from
;; FDTDIR /gnu/store/ls1byzmapi911cylh4s6044x0cmc61c8-linux-libre-pinebook-pro-5.6.0/lib/dtbs
;; to
;; FDTDIR /gnu/store/ls1byzmapi911cylh4s6044x0cmc61c8-linux-libre-pinebook-pro-5.6.0/lib/dtbs/rockchip
