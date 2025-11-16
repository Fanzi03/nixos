{pkgs, ...}: 
{
	home.packages = with pkgs; [
		wofi
	];

	xdg.configFile."wofi/style.css".source = ./style.css;	
	xdg.configFile."wofi/config".source = ./config;
}
