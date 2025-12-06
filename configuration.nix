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

	services.zapret = {
		enable = true;
		whitelist = [
			"youtube.com"
			"googlevideo.com"
			"ytimg.com"
			"youtu.be"
			"discord.com"
			"discord-attachmets-uploads-prd.storagee.googleapis.com"
			"googleapis.com"	
		];
		params = [
			"--dpi-desync=fake,disorder2"
			"--dpi-desync-ttl=1"
			"--dpi-desync-autottl=2"
		];
	};

  networking.hostName = "btw"; # Define your hostname.

  # Set your time zone.
   time.timeZone = "Asia/Ulaanbaatar";

   nixpkgs.config.allowUnfree = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   #hardwnetworking.networkmanager.enable = true;

  services.xserver = {
	desktopManager.lxqt.enable = true;
	#displayManager.lightdm.enable = true;
  	enable = true;

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

 security.rtkit.enable = true;
 services.pipewire = {
 	enable = true;
	alsa.enable = true;
 	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
};

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

   users.users.btw = {
     isNormalUser = true;
     description = "btw";
     extraGroups = [ "audio" "wheel" "networkmanager" "input" "video" "seat" "docker" "lp" ]; # Enable ‘sudo’ for the user.
     password = "123";
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
     neofetch
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
     parted
     usbimager

     # Dev
     openjdk21
     gradle
     jdt-language-server
     haskellPackages.timestamper	
     lombok
     pacman
     rustup 
     gcc

   ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
