{config, pkgs, ...}:
{
	nixpkgs.config = { allowUnfree = true; };
	services = {
		printing = {
			enable = true;
			drivers = with pkgs; [
				pantum-driver
				#				cups
			];
		};
	};

	services.system-config-printer.enable = true;
	hardware.sane.enable = true;
	hardware.sane.extraBackends = [ pkgs.pantum-driver];

	hardware.printers = {
		ensurePrinters = [
			{
				name = "Pantum_M6500_series";
				location = "Home";
				deviceUri = "usb://Pantum/M6500%20series?serial=CE5AV00FU1";
				model = "Pantum/Pantum M6500 Series.ppd";
				ppdOptions = {
        				PageSize = "A4";
      				};
			}
		];
		ensureDefaultPrinter = "Pantum_M6500_series";
	};
}
