{ config, lib, pkgs, ... }:

{
  imports =
    [ 
#	/etc/nixos/hardware-configuration.nix
#	./optimize/hddbust.nix 
      ./hardware-configuration.nix
      ./optimize/printingSettings.nix
    ];


# Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["uinput" "i2c-dev" ];
#extraModulePackages = [];
    kernelParams = [
      "nvidia_drm.modeset=1"
        "nvidia_drm.fbdev=1"
        "usbcore.autosuspend=-1"
        "usb-storage.delay_use=0"
#desktop optimize
        "amd_pstate=active"
    ];
    kernel.sysctl = {"net.ipv4.ip_forward" = 1;};
    blacklistedKernelModules = [ "hid_uclogic" "wacom" ];
  };
  networking = { 
#wireless.regulatoryDomain = "RU";
    firewall = {
      enable = true;
# DHCP(67) и DNS(53) for hotpot
      allowedUDPPorts = [53 67 25565];
# TCP for DNS
      allowedTCPPorts = [53 25565];
      trustedInterfaces = [ "wlp14s0u3i2" "waydroid0" ];
    };
    nat = {
      enable = true;
      externalInterface = "enp5s0";
      internalInterfaces = [ "wlp14s0u3i2" ];
    };

    networkmanager = {
      enable = true;
#      unmanaged = ["wlp14s0u3i2"];
    };
    hostName = "nixos"; 
  };

  time.timeZone = "Asia/Ulaanbaatar";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;

        verbatimConfig = ''
          user = "fanzi03"
          group = "libvirtd"

          graphics_device_acl = [
              "/dev/dri/renderD128", "/dev/dri/card0",
              "/dev/nvidia0", "/dev/nvidiactl", "/dev/nvidia-modeset"
          ]

          cgroup_device_acl = [
              "/dev/null", "/dev/full", "/dev/zero",
              "/dev/random", "/dev/urandom",
              "/dev/ptmx", "/dev/kvm", "/dev/rtc",
              "/dev/tty", "/dev/nvidia0", "/dev/nvidiactl",
              "/dev/nvidia-modeset", "/dev/dri/renderD128"
          ]
        '';
      };
    };
    waydroid.enable = true;
    docker = {
      enable = true;
    };
  };

  services = {
    udev.extraRules = ''
# Права для виртуального устройства OTD
      KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
# Права для самого Gaomon (USB ID 256c:006f)
      KERNEL=="hidraw*", ATTRS{idVendor}=="256c", ATTRS{idProduct}=="006f", MODE="0666", GROUP="input"
#Права для detect monitors
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
      '';
    blueman.enable = true; 
    openssh.enable = true;
    getty.autologinUser = "fanzi03";
    postgresql.enable = true;
    ollama = {
	package = pkgs.ollama-cuda;
	enable = true;
	#models = "/mnt/nvme/models";
    };
    #clamav = {
    #  daemon.enable = true;
    #  updater.enable = true;
    #}; #antivirus
    zapret.enable = true;
    zapret.whitelist =
      [
      "youtube.com"
        "googlevideo.com"
        "ytimg.com"
        "youtu.be"
        "discord.com"
        "discord-attachmets-uploads-prd.storage.googleapis.com"
        "googleapis.com"
      ];
    zapret.params =
      [
      "--dpi-desync=fake,disorder2"
        "--dpi-desync-ttl=1"
        "--dpi-desync-autottl=2"
      ];
    haveged.enable = true;
    create_ap = {
      enable = false;
      settings = {
        INTERNET_IFACE = "enp5s0";
        WIFI_IFACE  = "wlp14s0u3i2";
        SSID =  "NixOs_Hotspot";
        PASSPHRASE = "244lpGentoo1";
        NO_VIRT = 1;
        FREQ_BAND = "2.4";#"5";
        CHANNEL = "1";#"36";
        DRIVER = "nl80211";
        COUNTRY = "RU";
	#2.4freq and channel <= 13
	#5freq and channel > 13
      };

    };

    samba = {
      enable = true;
      openFirewall = true;
      settings = {
         global = {
            "workgroup" = "WORKGROUP";
            "server string" = "NixOS Samba Server";
            "netbios name" = "nixos-host";
            "security" = "user";
          };
          # Название папки, которое увидит Windows
        "common_folder" = {
          "path" = "/mnt/nvme/virtual_machines/common_folder"; 
          "writable" = "yes";
          "force user" = "fanzi03";
        };
      };
    };

  };
  systemd.services = {
    create_ap = {
        after = [ "network-online.target" "NetworkManager.service" ];
        wants = [ "network-online.target" ];
        serviceConfig = {
          Restart = "on-failure";
          RestartSec = "5s";
          ExecStartPre =  "${pkgs.coreutils}/bin/sleep 3";
        };
    };

    libvirtd.serviceConfig = {
      Environment = [
        # Указываем QEMU искать драйверы в системных путях NixOS
        "LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib"
        "GBM_BACKEND=nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME=nvidia"

        # Права на hyprland
        "XDG_RUNTIME_DIR=/run/user/1000"
        "WAYLAND_DISPLAY=wayland-1"
        "DISPLAY=:0"
      ];
    };
    ollama.serviceConfig = {
	  # Разрешаем доступ на чтение и запись к конкретной папке на NVMe
	  ReadWritePaths = [ "/mnt/nvme/models" ];
    };
  };
  programs = {
    steam.gamescopeSession.enable = true;
    virt-manager.enable = true; # виртуалка
	nix-ld.enable = true;
    firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };
  hardware = {
    opentabletdriver.enable = true;
    wirelessRegulatoryDatabase = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
# Nvidia
    nvidia = {
      modesetting.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      nvidiaSettings = true;
    };
    nvidia-container-toolkit.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    }; 

  }; 
#services
  services.xserver = {
#	enable = true;
#windowManager.i3.enable = true;
   
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };
#programs.sway.enable = true;


  services.dbus = {
    enable = true;
    packages = with pkgs; [
      dconf
        gcr
        udisks2
    ];
  };

  programs.dconf.enable = true;

#devices
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = ["gtk" ]; #"*"
    xdgOpenUsePortal = true;
  };

  fonts = {

    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      fira-code
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
    ];
  };

  environment.sessionVariables = {
#WLR_NO_HARDWARE_CURSORS = "1";  
    NIXOS_OZONE_WL = "1";           
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

# layout
    XKB_DEFAULT_LAYOUT = "us,ru";
    XKB_DEFAULT_OPTIONS = "grp:alt_shift_toggle";	

# firefox
    MOZ_USE_XINPUT2 = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    MOZ_X11_EGL = "1";
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.flatpak.enable = true;

  users.users.fanzi03 = {
    isNormalUser = true;
    description = "Fanzi";
    extraGroups = [ "audio" "wheel" "networkmanager" "input" "uinput" "video" "seat" "docker" "lp" "adbusers" "scanner" "libvirtd" "kvm" "sudo" "i2c" ]; # Enable ‘sudo’ for the user.
      password = "$6$7x/cfdaQ0Zm44XeY$iouwwP9xb8yNoCPEv2Gh/g22/faQI/UVGsI6R0aTpVPEpuV3.gTbBP7W4u2CyeSzGkk1BjM6GK93mj4P7CIF.1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4pZh8cq6a2cQfFF3Qv9vBlBzjWfqiIGWCUtdgys7ZX fanzi03@nixos"
    ];
    packages = with pkgs; [
      tree
        git
    ];
  };
  users.groups = {
    i2c = {};
    group = {};
  };
  users.groups.libvirtd.members = ["fanzi03"];

  programs.java.enable = true;

  environment.sessionVariables = {
    JAVA_HOME = "${pkgs.openjdk25}/lib/openjdk";
  };
  environment.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; then 
      systemctl restart --user opentabletdriver
      exec Hyprland
        fi
        '';

  environment.systemPackages = with pkgs; [
    exfatprogs
     chromium
      bsd-finger
      iw
      gnirehtet
      vim     
      wget
      neovim
      git
      cups
      gimp
      obsidian
      steam
      nftables
      home-manager
      unzip
      grim
      slurp
      wl-clipboard
      swappy
      usbutils
      htop
      iotop
      steam-run
      parted

# Dev
      openjdk25
#openjdk25
#javaPackages.compiler
      gradle
      docker
      docker-compose
#postman
      jdt-language-server
      lombok
      lolcat
      pacman
      maven
      gcc

      direnv
      nix-direnv
# nvidia
      nvidia-docker
      libnvidia-container
      nvidia-container-toolkit
      wgnord
      kdePackages.dolphin
      #python315
      python313Packages.tkinter
      python313Packages.python
      libx11
      tcl
      tk
      xorg.xorgproto
      disko
      zsh
      btrfs-progs
      kdiskmark
      smartmontools
      postgresql
      zip
      virt-manager
      virt-viewer
      spice
      spice-gtk
      android-tools
      gamescope
      
      cozy #audioplayer
      vscode
      #chromium


      ];

  system.stateVersion = "26.05"; # Did you read the comment? yessssssssss
}
