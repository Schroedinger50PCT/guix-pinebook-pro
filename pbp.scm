(use-modules
 (guix packages)
 (guix download)
 (guix licenses)
 (guix gexp)
 (guix git-download)
 (guix build-system trivial)
 (gnu)
 (gnu bootloader u-boot)
 (gnu system nss)
 (gnu packages)
 (srfi srfi-1))

(use-service-modules audio
		     cups
		     dbus
		     desktop
		     networking
		     mcron
		     sound
		     ssh
		     xorg)

(use-package-modules admin audio
		     bash bootloaders 
                     certs curl cups
                     pulseaudio emacs emacs-xyz 
		     freedesktop
                     graphviz games guile guile-xyz 
                     rsync rust-apps
		     image
		     matrix  messaging
                     package-management 
                     wm rsync
                     shells shellutils skribilo scanner ssh
                     text-editors tls terminals
                     video 
                     gimp graphics 
                     wget 
                     disk  
                     xorg xdisorg
		     linux
		     fonts)
(operating-system (kernel linux-libre-arm64-generic) 
		  (kernel-arguments '("modprobe.blacklist=pcspkr,snd_pcsp")) ;"ethaddr=${ethaddr}" "eth1addr=${eth1addr}" "serial=${serial#}" "video=HDMI-A-1:1920x1080@60" "video=eDP-1:1920x1080@60" "vga=current"))
		  (initrd-modules '())
		  (host-name "pinebook")
		  (timezone "Europe/Berlin")
		  (locale "en_US.utf8")
		  (keyboard-layout (keyboard-layout "us"))
                  
		  (bootloader (bootloader-configuration 
               		       (bootloader u-boot-pinebook-pro-rk3399-bootloader) 
               		       (targets '("/dev/sda" ))))
                  
		  (file-systems (append (list 
					 (file-system (device  (uuid
					;"123513da-1a76-4343-8471-83d9b51590ac" ))							       
					;"0da37f27-c248-4c9c-9b28-31bcadc9f459"))
								"849aa075-18e3-42f5-922d-d1e1634869db"))
					;"aa92feec-86ef-4675-bcfb-3087ca513b20")) 
					   	      (mount-point "/")
					   	      (type "ext4"))) %base-file-systems))
					;(swap-devices (list "/dev/sda3"))

		  (users (append (list  
				  (user-account (name "botty") 
						(comment "Botty Mac Botface")
						(group "users") 
						(supplementary-groups '("wheel" "netdev" "audio" "video" "lp")) ;lpadmin 
						(home-directory "/home/botty")
						(password (crypt "botty" "3d8n7")))          
				  (user-account (name "root") 
						(uid 0)
						(comment "")
						(group "root")
						(password (crypt "root" "6h94ll")))) %base-user-accounts))
		  (issue "")
		  (packages (append (list alsa-lib alsa-utils acpid
					  

					  ;; emacs
					  ;emacs-gnugo
					  emacs-tramp emacs-which-key
					  ;emacs-openwith emacs-ox-pandoc emacs-guix
					  emacs-company
					  emacs-all-the-icons-dired
					  emacs-all-the-icons
					  emacs-selectrum emacs-prescient
					  ;emacs-matrix-client
					  emacs-org
					  emacs-org-roam 
                 			  emacs-next-pgtk

					  ;; cli-tools
					  aspell
					  fdisk
					  font-iosevka
					  font-tamzen
					  graphicsmagick
					  bluez
					  bluez-alsa
					  curl
					  dropbear
					  ;gnugo 
					  git
					  gpm
					  grim graphviz

					  ;; gui-tools
					  ;gimp 
					  ;gnucap ngspice 
					  mpv you-get
					  pipewire
					  rsync
					  slurp
					  sway
					;waypipe
					  wget
					  wpa-supplicant wl-clipboard
					  xdg-utils
					  xdg-desktop-portal xdg-desktop-portal-wlr
				       
					  nss-certs) %base-packages))
		  (define emacs-daemon
		    (make <service>
		      #:provides '(emacs-daemon)
		      #:docstring "Run the emacs daemon"
		      #:start (make-forkexec-constructor '("emacs" "--fg-daemon"))
		      #:stop (make-kill-destructor)
		      #:respawn? #t))

		  (define pipewire-daemon
		    (make <service>
		      #:provides '(pipewire-daemon)
		      #:docstring "Run the pipewire daemon"
		      #:start (make-forkexec-constructor '("pipewire"))
		      #:stop (make-kill-destructor)
		      #:respawn? #t))

		  (services (append (list
				     (service pipewire-daemon)
				     (service emacs-daemon)
			       	     (service gpm-service-type)
					;(service sane-service-type sane-backends) ; mit xsane oder so verwenden

				     (service cups-service-type
					      (cups-configuration
					       (web-interface? #t)
					       (default-paper-size "A4")
					       (extensions (list cups-filters epson-inkjet-printer-escpr hplip-minimal))))

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
				     (dropbear-service (dropbear-configuration (port-number 22)
									       (root-login? #t)
									       (password-authentication? #f)))
				     ;(bluetooth-service #:auto-enable? #t)
				     (service elogind-service-type (elogind-configuration
								    (kill-user-processes? #f)
								    (kill-exclude-users ("root"))
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
					;(authorize-key? #t)
					;(authorized-keys %default-authorized-guix-keys)
					;(use-substitutes? #t)
					;(substitute-urls %default-substitute-urls)
					;(max-silent-time 0)
					;(timeout 0)
					;(log-compression 'bzip2)
					;(extra-options '())
					;(log-file "/var/log/guix-daemon.log")
					;(http-proxy #t)
	    									   (tmpdir "/build"))) )))
		  (name-service-switch %mdns-host-lookup-nss))

