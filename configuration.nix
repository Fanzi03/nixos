{ config, lib, pkgs, ... }:

#let 
#	home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;	
#in
{
  imports =
    [ # Include the results of the hardware scan. 
#	/etc/nixos/hardware-configuration.nix
#	./optimize/hddbust.nix 
	./hardware-configuration.nix
	./optimize/printingSettings.nix
# 	(import "${home-manager}/nixos")
    ];

	# this means that the home-manager will be dependent on config not flake
	#home-manager.useUserPackages = true;
	#home-manager.useGlobalPkgs = true;
	#home-manager.backupFileExtension = "backup";
	#home-manager.users.fanzi03 = import ./home.nix;
  

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
  	"nvidia_drm.modeset=1"
	"nvidia_drm.fbdev=1"
	"usbcore.autosuspend=-1"
	"usb-storage.delay_use=0"
	#desktop optimize
	"amd_pstate=active"
  ];

  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
   time.timeZone = "Asia/Ulaanbaatar";

   nixpkgs.config.allowUnfree = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   virtualisation.docker = {
	enable = true;
   };

   programs = {
	hyprland = {
		enable = true;
		withUWSM = true;
		xwayland.enable = true;
	};
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

  #devices
  xdg.portal = {
  	enable = true;
	wlr.enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.sessionVariables = {
    	WLR_NO_HARDWARE_CURSORS = "1";  
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
     extraGroups = [ "audio" "wheel" "networkmanager" "input" "video" "seat" "docker" "lp" ]; # Enable ‘sudo’ for the user.
     password = "13015ltfellyaml";
     packages = with pkgs; [
       tree
       git
     ];
   };

   programs.firefox.enable = true;
   programs.java.enable = true;

environment.sessionVariables = {
		JAVA_HOME = "${pkgs.openjdk21}"; 
};

environment.systemPackages = with pkgs; [
     vim     
     wget
     neovim
     hyprland
     hyprpaper
     git
     cups
     gimp
     wofi
     nwg-look
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
     usbimager

     # Dev
     openjdk21
     gradle
     docker
     docker-compose
     postman
     jdt-language-server
     haskellPackages.timestamper	
     lombok
     lolcat
     pacman
     maven
     rustup 
     gcc

     # nvidia
     nvidia-docker
     libnvidia-container
     nvidia-container-toolkit
     
   ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
