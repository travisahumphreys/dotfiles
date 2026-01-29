{
  inputs,
  pkgs,
  ...
}:{
# ── Idle daemon ───────────────────────────────────────────
services.hypridle = {
  enable = true;
  settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
    };

    listener = [
      # Dim screen
      {
        timeout = 150; # 2.5 min
        on-timeout = "brightnessctl -s set 10%";
        on-resume = "brightnessctl -r";
      }
      # Lock
      {
        timeout = 300; # 5 min
        on-timeout = "loginctl lock-session";
      }
      # Screen off
      {
        timeout = 330; # 5.5 min
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
      # Suspend (optional — remove if you don't want this)
      {
        timeout = 600; # 10 min
        on-timeout = "systemctl suspend";
      }
    ];
  };
};
  
  systemd.user.services.hypridle = {
    Unit = {
      After = [ "hyprland-session.target" ];
      PartOf = [ "hyprland-session.target" ];
    };
    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
  };


# ── Lock screen ───────────────────────────────────────────
programs.hyprlock = {
  enable = true;
  package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.default;
  settings = {
    general = {
      hide_cursor = true;
      grace = 5; # seconds before lock actually engages
      disable_loading_bar = false;
    };
    auth = {
      fingerprint = {
        enabled = true;
        ready_message = "Scan fingerprint to unlock";
        present_message = "Scanning...";
      };
    };
    background = [
      {
        monitor = "";
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
        noise = 0.02;
        contrast = 0.9;
        brightness = 0.6;
      }
    ];

    input-field = [
      {
        monitor = "";
        size = "250, 50";
        outline_thickness = 2;
        dots_size = 0.26;
        dots_spacing = 0.15;
        dots_center = true;
        outer_color = "rgb(89, 180, 250)"; # blue
        inner_color = "rgb(30, 30, 46)"; # base
        font_color = "rgb(205, 214, 244)"; # text
        fade_on_empty = true;
        placeholder_text = "";
        hide_input = false;
        check_color = "rgb(166, 227, 161)"; # green
        fail_color = "rgb(243, 139, 168)"; # red
        fail_text = "";
        position = "0, -20";
        halign = "center";
        valign = "center";
      }
    ];

    label = [
      # Time
      {
        monitor = "";
        text = "$TIME";
        color = "rgb(205, 214, 244)";
        font_size = 72;
        font_family = "CaskaydiaCove Nerd Font Bold";
        position = "0, 150";
        halign = "center";
        valign = "center";
      }
      # Date
      {
        monitor = "";
        text = ''cmd[update:3600000] date +"%A, %B %d"'';
        color = "rgb(186, 194, 222)"; # subtext1
        font_size = 20;
        font_family = "CaskaydiaCove Nerd Font Italic";
        position = "0, 80";
        halign = "center";
        valign = "center";
      }
      # Fingerprint
      {
        monitor = "";
        text = "$FPRINTPROMPT";
        color = "rgb(166, 227, 161)";  # green, or whatever you prefer
        font_size = 14;
        font_family = "CaskaydiaCove Nerd Fon";
        position = "0, -80";  # below the input field
        halign = "center";
        valign = "center";
      }
      {
        monitor = "";
        # The icon might need a space depending on your preference
        text = ''cmd[update:1000] echo "<span>$(cat /sys/class/power_supply/BAT0/capacity)% 🔋</span>"'';
        color = "rgb(205, 214, 244)";
        font_size = 16;
        font_family = "CaskaydiaCove Nerd Font";
        position = "-20, 20";
        halign = "right";
        valign = "bottom";
      }
    ];
  };
};
# ```
#
# Then add a keybind in your Hyprland config:
# ```
# bind = SUPER, L, exec, loginctl lock-session
}
