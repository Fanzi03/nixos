{ config, lib, pkgs, ... }:

{
  imports =
    [ 
#	/etc/nixos/hardware-configuration.nix
#	./optimize/hddbust.nix 
	./hardware-configuration.nix
	./optimize/printingSettings.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot = {
        loader = {
                systemd-boot.enable = true;
                efi.canTouchEfiVariables = true;
        };
        kernelModules = ["uinput"];
#extraModulePackages = [];
        kernelParams = [
                "nvidia_drm.modeset=1"
                "nvidia_drm.fbdev=1"
                "usbcore.autosuspend=-1"
                "usb-storage.delay_use=0"
                #desktop optimize
                "amd_pstate=active"
        ];
        kernel.sysctl = {"net.ipv4.ip_forward" = 1;};
        blacklistedKernelModules = [ "hid_uclogic" "wacom" ];
  };
  networking = { 
#wireless.regulatoryDomain = "RU";
        firewall = {
                enable = true;
                # DHCP(67) и DNS(53) for hotpot
                allowedUDPPorts = [53 67];
                # TCP for DNS
                allowedTCPPorts = [53];
                trustedInterfaces = [ "wlp13s0u3i2" "waydroid0" ];
        };
        nat = {
                enable = true;
                externalInterface = "enp5s0";
                internalInterfaces = [ "wlp13s0u3i2" ];
        };

        networkmanager = {
                enable = true;
                #unmanaged = ["wlp13s0u3i2"];
        };
        hostName = "nixos"; 
  };

   time.timeZone = "Asia/Ulaanbaatar";

   nixpkgs.config.allowUnfree = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   virtualisation = {
        waydroid.enable = true;
        docker = {
	        enable = true;
        };
   };

        services = {
                udev.extraRules = ''
  # Права для виртуального устройства OTD
  KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  # Права для самого Gaomon (USB ID 256c:006f)
  KERNEL=="hidraw*", ATTRS{idVendor}=="256c", ATTRS{idProduct}=="006f", MODE="0666", GROUP="input"
                '';
                blueman.enable = true; 
                openssh.enable = true;
                getty.autologinUser = "fanzi03";
                zapret.enable = true;
                zapret.whitelist =
                        [
                                "youtube.com"
                                "googlevideo.com"
                                "ytimg.com"
                                "youtu.be"
                                "discord.com"
                                "discord-attachmets-uploads-prd.storage.googleapis.com"
                                "googleapis.com"
                        ];
                zapret.params =
                        [
                                "--dpi-desync=fake,disorder2"
                                "--dpi-desync-ttl=1"
                                "--dpi-desync-autottl=2"
                        ];
                haveged.enable = true;
                create_ap = {
                        enable = true;
                        settings = {
                                INTERNET_IFACE = "enp5s0";
                                WIFI_IFACE  = "wlp13s0u3i2";
                                SSID =  "NixOs_Hotspot";
                                PASSPHRASE = "244lpGentoo1";
                                NO_VIRT = 1;
                                FREQ_BAND = "5";#"2.4";
                                CHANNEL = "36";#"1";
                                DRIVER = "nl80211";
                                COUNTRY = "RU";
                        };
                        
                };

        };
        systemd.services.create_ap = {
                after = [ "network-online.target" "NetworkManager.service" ];
                wants = [ "network-online.target" ];
                serviceConfig = {
                        Restart = "on-failure";
                        RestartSec = "5s";
                        ExecStartPre =  "${pkgs.coreutils}/bin/sleep 3";
                };
        };
	programs = {
                adb.enable = true;
	};
  hardware = {
        opentabletdriver.enable = true;
        wirelessRegulatoryDatabase = true;
        bluetooth = {
                enable = true;
                powerOnBoot = true;
        };
        # Nvidia
	nvidia = {
		modesetting.enable = true;
		open = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		powerManagement = {
			enable = false;
			finegrained = false;
		};
		nvidiaSettings = true;
	};
	nvidia-container-toolkit.enable = true;
	graphics = {
		enable = true;
		enable32Bit = true;
	}; 

  }; 
   #services
  services.xserver = {
  	videoDrivers = [ "nvidia" ];
	xkb = {
		layout = "us,ru";
		options = "grp:alt_shift_toggle";
	};
  };


  services.dbus = {
  	enable = true;
	packages = with pkgs; [
		dconf
		gcr
		udisks2
	];
  };

  programs.dconf.enable = true;

  #devices
  xdg.portal = {
  	enable = true;
	wlr.enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
  };

 fonts = {

	enableDefaultPackages = true;
        fontDir.enable = true;

	packages = with pkgs; [
		fira-code
                nerd-fonts.fira-code
                nerd-fonts.fira-mono
	];
 };

  environment.sessionVariables = {
	#WLR_NO_HARDWARE_CURSORS = "1";  
    	NIXOS_OZONE_WL = "1";           
	GBM_BACKEND = "nvidia-drm";
  	__GLX_VENDOR_LIBRARY_NAME = "nvidia";

	# layout
	XKB_DEFAULT_LAYOUT = "us,ru";
	XKB_DEFAULT_OPTIONS = "grp:alt_shift_toggle";	

	# firefox
	MOZ_USE_XINPUT2 = "1";
  	MOZ_ENABLE_WAYLAND = "1";
  	MOZ_WEBRENDER = "1";
  	MOZ_X11_EGL = "1";
  };
 security.rtkit.enable = true;
 services.pipewire = {
 	enable = true;
	alsa.enable = true;
 	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
};
 services.flatpak.enable = true;

   users.users.fanzi03 = {
     isNormalUser = true;
     description = "Fanzi";
     extraGroups = [ "audio" "wheel" "networkmanager" "input" "uinput" "video" "seat" "docker" "lp" "adbusers" "scanner"]; # Enable ‘sudo’ for the user.
     password = "$6$7x/cfdaQ0Zm44XeY$iouwwP9xb8yNoCPEv2Gh/g22/faQI/UVGsI6R0aTpVPEpuV3.gTbBP7W4u2CyeSzGkk1BjM6GK93mj4P7CIF.1";
        openssh.authorizedKeys.keys = [
         "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4pZh8cq6a2cQfFF3Qv9vBlBzjWfqiIGWCUtdgys7ZX fanzi03@nixos"
        ];
     packages = with pkgs; [
       tree
       git
     ];
   };

   programs.firefox.enable = true;
   programs.java.enable = true;

environment.sessionVariables = {
  JAVA_HOME = "${pkgs.openjdk21}/lib/openjdk";
};
environment.loginShellInit = ''
        if [ "$(tty)" = "/dev/tty1" ]; then 
                exec Hyprland
        fi
'';
  
environment.systemPackages = with pkgs; [
        bsd-finger
        iw
     gnirehtet
     vim     
     wget
     neovim
     git
     cups
     gimp
     neofetch
     obsidian
     steam
     nftables
     home-manager
     unzip
     grim
     slurp
     wl-clipboard
     swappy
     usbutils
     htop
     iotop
     steam-run
     parted

     # Dev
     openjdk21
	#openjdk25
                #javaPackages.compiler
     gradle
     docker
     docker-compose
     #postman
     jdt-language-server
     lombok
     lolcat
     pacman
     maven
     gcc

     direnv
     nix-direnv
     # nvidia
     nvidia-docker
     libnvidia-container
     nvidia-container-toolkit

   ];

  system.stateVersion = "25.11"; # Did you read the comment? yessssssssss
}
