{
	programs.bash = {
		enable = true;
		shellAliases = {
			rebuild = "sudo nixos-rebuild switch";
			rh = "home-manager switch --flake ~/nixos-dotfiles/home-manager/flake.nix/";
			configuration = "sudo -E nvim /etc/nixos/configuration.nix";
			ehm = "cd ~/nixos-dotfiles/home-manager && sudo nvim .";
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
