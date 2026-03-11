{
  pkgs,
  inputs,
  ...
}:
{
  services = {
    hyprpaper = {
      enable = true;
      package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        ipc = "on";
        splash = false;
        wallpaper = [
          {
            monitor = "eDP-1";
            path = "/home/travis/dotfiles/hypr/wall.png";
          }
        ];
      };
    };
  };

  systemd.user.services.hyprpaper = {
    Unit = {
      After = [ "hyprland-session.target" ];
      PartOf = [ "hyprland-session.target" ];
    };
    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
  };
}
