{config, pkgs, ... }:  

{
# Оптимизация mount опций для HDD
	fileSystems."/" = {
		device = "/dev/disk/by-uuid/86306e66-3304-4359-82d8-31e702e4c60a";
		fsType = "ext4";
		options = [ "noatime" "nodiratime" "commit=120" ];
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/3C89-77AB";
		fsType = "vfat";
		options = [ "fmask=0077" "dmask=0077" "noatime" ];
	};

# Оптимизация readahead
	systemd.services.optimize-disks = {
		description = "Optimize disk settings";
		wantedBy = [ "multi-user.target" ];
		serviceConfig = {
			Type = "oneshot";
			ExecStart = [
				"${pkgs.util-linux}/bin/blockdev --setra 4096 /dev/sdb"  # HDD - большой readahead
					"${pkgs.util-linux}/bin/blockdev --setra 256 /dev/sda"   # SSD - малый readahead
			];
		};
	};

# Включить zram swap для компенсации медленного HDD
	zramSwap = {
		enable = true;
		algorithm = "lz4";
		memoryPercent = 25; # 25% от RAM = ~4GB
	};
}
