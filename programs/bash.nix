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
		};	
		initExtra = ''
      			update_kitty_title() {
	  		local layout=$(setxkbmap -query 2>/dev/null | grep layout | awk '{print $2}')
	  		case $layout in 
				"us") echo -ne "\033]0;🇺🇸 $(basename "$PWD")\007" ;;
	      			"ru") echo -ne "\033]0;🇷🇺 $(basename "$PWD")\007" ;;
	      		*) echo -ne "\033]0;🌐 $(basename "$PWD")\007" ;;
	  		esac
      			}

      			PROMPT_COMMAND="update_kitty_title; $PROMPT_COMMAND"	
		'';
	};
}
