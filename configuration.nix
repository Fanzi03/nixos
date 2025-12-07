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

   time.timeZone = "Asia/Ulaanbaatar";

   nixpkgs.config.allowUnfree = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   virtualisation.docker = {
	enable = true;
   };

	services.zapret.enable = true;
	services.zapret.whitelist =
	[
		"youtube.com"
		"googlevideo.com"
		"ytimg.com"
		"youtu.be"
		"discord.com"
		"discord-attachmets-uploads-prd.storage.googleapis.com"
		"googleapis.com"
	];
	services.zapret.params =
	[
		"--dpi-desync=fake,disorder2"
		"--dpi-desync-ttl=1"
		"--dpi-desync-autottl=2"
	];

	# programs = {
	#hyprland = {
	#	enable = true;
	#	withUWSM = true;
	#	xwayland.enable = true;
	#};
	#};
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
  };

 fonts = {

	enableDefaultFonts = true;

	packages = with pkgs; [
		fira-code
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
     git
     cups
     gimp
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

  system.stateVersion = "25.05"; # Did you read the comment? yessssssssss
}
