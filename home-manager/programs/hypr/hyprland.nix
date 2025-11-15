{pkgs, ...}: {
	home.packages = with pkgs; [
		hyprpaper
	];

	xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;

	wayland.windowManager.hyprland = {
		enable = true;

		xwayland.enable = true;

		extraConfig = ''
			${builtins.readFile ./hyprland.conf}
		'';
	};
}
