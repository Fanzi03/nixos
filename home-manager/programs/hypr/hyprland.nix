{pkgs,pkgs-old, ...}: {
	home.packages = with pkgs; [
		hyprpaper
    hyprsunset
		ddcutil
		swww
		kitty
	];

	xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
	xdg.configFile."hypr/hyprsunset.conf".source = ./hyprsunset.conf;
	xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
	

	wayland.windowManager.hyprland = {
	#programs.hyprland = {
		enable = true;
    package = pkgs-old.hyprland;
    portalPackage = pkgs-old.xdg-desktop-portal-hyprland; 
		xwayland.enable = true;

		#extraConfig = ''
		#	${builtins.readFile ./hyprland.conf}
		#'';
	};
}
