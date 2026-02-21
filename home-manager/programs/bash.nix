{
	programs.bash = {
		enable = true;
		shellAliases = {
			rebuild = "sudo nixos-rebuild switch";
                        rebuildf = "cd && sudo nixos-rebuild switch --flake ./nixos-dotfiles";
			rh = "home-manager switch --flake ~/nixos-dotfiles/home-manager/flake.nix/#fanzi03";
			configuration = "sudo -E nvim /nixos-dotfiles/nixos-dotfiles/configuration.nix";
                        chw = "cd ~/fastData/chopping_wood";
			ehm = "cd ~/nixos-dotfiles/home-manager && sudo nvim .";
			Envim = "sudo nvim ~/nixos-dotfiles/home-manager/programs/neovim.nix";
			projects = "cd ~/fastData/everything_is_there/ && nvim .";
			projectsD = "cd ~/fastData/";
			zapretD = "(cd ~/fastData/zapret-discord-youtube-linux && sudo ./main_script.sh)";
                        nvf = "nix run ~/nixos-dotfiles";

			minecraft = "cd ~/mine && steam-run java -jar TLauncher.jar";
			grt = "gradle clean test --rerun-tasks --info";
			Ehypr = "nvim ~/.config/hypr/hyprland.conf";
		};	
	};
}
