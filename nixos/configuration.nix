{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/localization.nix
    ./modules/retroarch.nix
  ];

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;      
      efi.canTouchEfiVariables = true;   
    };
  };

  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
    bluetooth = {
      enable = true;                                                           
      powerOnBoot = true;
    };
  };
 
  networking = {
    hostName = "thinkpad";
    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  
  nix = {
    extraOptions = ''experimental-features = nix-command flakes'';
    settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

  security.rtkit.enable = true;
  security.pam.services = {
    sudo.fprintAuth = false;
    su.fprintAuth = false;
    polkit-1.fprintAuth = false;
    # login.fprintAuth = false;      # TTY login
  };
# security.polkit.extraConfig = ''
#   polkit.addRule(function(action, subject) {
#     if (action.id == "net.reactivated.fprint.device.verify") {
#       return polkit.Result.YES;
#     }
#   });
# '';

  users.users.travis = {
    isNormalUser = true;
    description = "travis";
    extraGroups = ["networkmanager" "wheel" "input"];
  };

  programs = {
    hyprland = {
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      enable = true;
    };

    git = {
      enable = true;
    };

    yazi = {
      enable = true;
    };
    
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };

    dconf.enable = true;
    
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        marksman
        icu
        # Add any missing dynamic libraries for unpackaged programs
      ];
    };

    nix-index = {
      enable = true;
      enableBashIntegration = true;  # or zshIntegration/fishIntegration
    };
    
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      ibm-plex
      dejavu_fonts
      noto-fonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font" ];
        sansSerif = [ "CaskaydiaCove Nerd Font" "Noto Sans" ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
  
  environment = {  
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    
    systemPackages = with pkgs; [
      
    # ---------- System Utilites ----------------- #
    zig # compiler
    glibc
    gcc
    gnumake # compiler
    clang

    # ---------- Hardware Control ---------------- #
    pavucontrol # Pipwire Volume Control
    brightnessctl 

    # ---------- Wayland / hypr Utilites --------- #
    hyprshot
    hyprpolkitagent
    wl-clipboard # clipboard hook
    ];
  };  
  
  services = {
    displayManager = { 
      ly.enable = true;
      ly.settings = {animation = "doom";};
    };

    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    fprintd.enable = true; 
    udisks2.enable = true;
    #upower.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 44100;
          "default.clock.quantum" = 512;
          "default.clock.min-quantum" = 512;
          "default.clock.max-quantum" = 512;
        };
      };
    };

    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null;
        UseDns = true;
        PermitRootLogin = "prohibit-password";
        LogLevel = "VERBOSE";
      };
    };
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
