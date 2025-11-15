{pkgs, ...}: {
	home.packages = with pkgs; [
		hyprpaper
		hyprland
	];
	xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;

	wayland.windowManager.hyprland = {
		enable = true;


		extraConfig = ''
			${builtins.readFile ./hyprland.conf}
		'';
	};
}
