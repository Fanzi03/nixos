{pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent= ''
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

      source ${./.p10k.zsh}
      setopt EXTENDED_GLOB
    '';

    shellAliases = {
      ll = "ls -l";
      inet = "sudo systemctl restart create_ap";
      rm = "rm -i";
      rebuild = "sudo nixos-rebuild switch";
      rebuildf = "cd && sudo nixos-rebuild switch --flake ./nixos-dotfiles";
      rh = "home-manager switch --flake ~/nixos-dotfiles/home-manager/flake.nix/#fanzi03";
      configuration = "sudo -E nvim /nixos-dotfiles/nixos-dotfiles/configuration.nix";
      chw = "cd ~/fastData/chopping_wood";
      ehm = "cd ~/nixos-dotfiles/home-manager && sudo nvim .";
      Envim = "sudo nvim ~/nixos-dotfiles/home-manager/programs/neovim.nix";
      projects = "cd ~/fastData/everything_is_there/ && nvim .";
      projectsD = "cd ~/fastData/";
      zapretD = "(cd ~/fastData/zapret-discord-youtube-linux && sudo ./service.sh)";
      nvim = "nix run ~/nixos-dotfiles";

      minecraft = "cd ~/mine && steam-run java -jar TLauncher.jar";
      grt = "gradle clean test --rerun-tasks --info";
      Ehypr = "nvim ~/.config/hypr/hyprland.conf";
      books = "cd /mnt/hdd/person_info/books/";
      clean_nix = "bash ~/nixos-dotfiles/home-manager/scripts/clean.sh";
    };
    history.size = 10000;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # 
      ];
    };
  };
}
