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
        extraModulePackages = [ config.boot.kernelPackages.rtl8821ce];
        kernelParams = [
                "nvidia_drm.modeset=1"
                "nvidia_drm.fbdev=1"
                "usbcore.autosuspend=-1"
                "usb-storage.delay_use=0"
                #desktop optimize
                "amd_pstate=active"
        ];
        kernel.sysctl = {"net.ipv4.ip_forward" = 1;};
        blacklistedKernelModules = [ "rtl8xxxu" ];
  };
  networking = { 
        firewall = {
                enable = true;
                # DHCP(67) и DNS(53) for hotpot
                allowedUDPPorts = [53 67];
                # TCP for DNS
                allowedTCPPorts = [53];
                trustedInterfaces = [ "wlp13s0u3i2" ];
        };
        networkmanager = {
                enable = true;
                unmanaged = ["wlp13s0u3i2"];
        };
        hostName = "nixos"; 
  };

   time.timeZone = "Asia/Ulaanbaatar";

   nixpkgs.config.allowUnfree = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   virtualisation.docker = {
	enable = true;
   };

        services = {
                openssh.enable = true;
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
                create_ap = {
                        enable = true;
                        settings = {
                                INTERNET_IFACE = "enp5s0";
                                WIFI_IFACE  = "wlp13s0u3i2";
                                SSID =  "NixOs_Hotspot";
                                PASSPHRASE = "244lpGentoo1";
                        };
                };

        };
	programs = {
                adb.enable = true;
	};
# Nvidia
  hardware = {
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
     extraGroups = [ "audio" "wheel" "networkmanager" "input" "video" "seat" "docker" "lp" "adbusers" "scanner"]; # Enable ‘sudo’ for the user.
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

#environment.sessionVariables = {};
  
environment.systemPackages = with pkgs; [
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
     openjdk25
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
