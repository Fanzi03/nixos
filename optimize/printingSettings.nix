{config, pkgs, ...}:
{
	services = {
		printing = {
			enable = true;
			drivers = with pkgs; [
				pantum-driver
				cups
			];
		};
	};

	services.system-config-printer.enable = true;
	hardware.sane.enable = true;
	hardware.sane.extraBackends = [ pkgs.pantum-driver];
}
