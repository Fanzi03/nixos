{
	programs.bash = {
		enable = true;
		shellAliases = {
			rebuild = "sudo nixos-rebuild switch";
			configuration = "sudo -E nvim /etc/nixos/configuration.nix";
			ehm = "cd /etc/nixos/ && sudo nvim .";
			Envim = "sudo nvim /etc/programs/neovim.nix";
			projects = "cd ~/fastData/everything_is_there/ && nvim .";
			projectsD = "cd ~/fastData/";
			zapretD = "(cd ~/fastData/zapret-discord-youtube-linux && sudo ./main_script.sh)";

			timers = "cd /etc/nixos/scripts && ./timers.sh";
			timersS = "cd /etc/nixos/scripts";
			minecraft = "cd ~/mine && steam-run java -jar TLauncher.jar";
			grt = "gradle clean test --rerun-tasks --info";
			Ehypr = "nvim ~/.config/hypr/hyprland.conf";
		};	
	};
}
