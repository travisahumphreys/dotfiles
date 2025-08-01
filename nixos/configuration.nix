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
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/localization.nix
    ./modules/retroarch.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  # hardware.graphics = {
  #   enable = true;
  # };

  # Enable networking
  networking.hostName = "thinkpad"; # Define your hostname.
  networking.networkmanager.enable = true;

  nix.extraOptions = ''experimental-features = nix-command flakes'';
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  services.displayManager.ly.enable = true;
  services.displayManager.ly.settings = {animation = "doom";};
  # services.greetd = {
  #  enable = true;
  #  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  security.rtkit.enable = true;
  services.pipewire = {
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.travis = {
    isNormalUser = true;
    description = "travis";
    extraGroups = ["networkmanager" "wheel" "input"];
    packages = with pkgs; [ claude-code ];
  };


  programs.hyprland = {
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    enable = true;
  };

  programs.git = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
  };
  # programs.gamescope = {
  #     enable = true;
  #     capSysNice = true;
  #   };
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [proton-ge-bin];
  };

  # programs.waybar.enable = true;

  programs.dconf.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
fonts = {
  packages = with pkgs; [
    nerd-fonts.caskaydia-cove
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
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    marksman
    icu
    # Add any missing dynamic libraries for unpackaged programs
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # editor
    zellij # terminal multiplexer
    kitty # terminal emulator
    lynx # tui web browser
    clipse # clipboard service
    btop # like htop
    fastfetch # look, me shiny
    dunst # notification daemon
    rofi-wayland # menu
    inkscape # vector graphics
    obsidian # note-taking with markdown
    zig # compiler
    glibc
    ags # widget system / black magic
    gnumake # compiler
    brightnessctl # wallpaper daemon
    hyprshot
    hyprpolkitagent
    alejandra
    deadnix
    freecad-wayland
    nixd
    wl-clipboard # clipboard hook
    udiskie
    catppuccin-cursors.mochaDark
    lazygit
    fzf
    clang
    go
    nodejs_22
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
    inputs.zen-browser.packages.${pkgs.system}.default
    ripgrep
    barcode
    zint
    imagemagick
    ghostscript
    visidata
  ];
  services.udisks2.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
 #  startWhenNeeded = true;
    ports = [22];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      PermitRootLogin = "prohibit-password";
      LogLevel = "VERBOSE";
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
