# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
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
      powerOnBoot = true; # powers up the default Bluetooth controller on boot 
    };
  };
 
  networking = {
    hostName = "thinkpad"; # Define your hostname.
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

  users.users.travis = {
    isNormalUser = true;
    description = "travis";
    extraGroups = ["networkmanager" "wheel" "input"];
    packages = with pkgs; [ claude-code ];
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
  
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.systemPackages = with pkgs; [
    neovim # editor
    zellij # terminal multiplexer
    kitty # terminal emulator
    lynx # tui web browser
    clipse # clipboard service
    btop # like htop
    fastfetch # look, me shiny
    dunst # notification daemon
    inkscape # vector graphics
    obsidian # note-taking with markdown
    zig # compiler
    glibc
    gcc
    ags # widget system / black magic
    gnumake # compiler
    brightnessctl # wallpaper daemon
    hyprshot
    hyprpolkitagent
    alejandra
    deadnix
    nixd
    wl-clipboard # clipboard hook
    udiskie
    catppuccin-cursors.mochaDark
    lazygit
    fzf
    clang
    go
    python3
    nodejs_25
    pavucontrol
    geekbench
    grim
    slurp
    zbar
    qrrs
    # deno # AstroLSP dependency
    wget # AstroLSP dependency
    unzip # AstroLSP dependency
    slides
    graph-easy
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ripgrep
    barcode
    zint-qt
    imagemagick
    ghostscript
    visidata
    quickshell
    pop
    github-cli
  ];
  
  services = {
    displayManager = { 
      ly.enable = true;
      ly.settings = {animation = "doom";};
    };

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    
    udisks2.enable = true;
    upower.enable = true;

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
