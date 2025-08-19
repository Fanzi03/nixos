{config, pkgs, ...}:
{
	services = {
		printing = {
			enable = true;
			drivers = with pkgs; [
				pantum-driver
				cups
				cups-filters
				gutenprint
				hplip
			];

			browsing = true;
			listenAddresses = [ "localhost:631" ];
			allowFrom = [ "all" ];
			defaultShared = false;
		};

		avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};
	};

	hardware.sane.enable = true;
	hardware.sane.extraBackends = [ pkgs.sane-airscan ];

	networking.firewall.allowedTCPPorts = [ 631 ];


}
