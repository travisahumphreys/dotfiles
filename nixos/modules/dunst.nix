{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # ── Geometry ────────────────────────────────────────
        width = 300;
        height = "(0, X)";
        origin = "top-right";
        offset = "10x10";
        corner_radius = 12;
        gap_size = 6;

        # ── Appearance ──────────────────────────────────────
        frame_width = 2;
        frame_color = "#89b4fa"; # blue
        separator_color = "frame";
        transparency = 0;

        # ── Text ────────────────────────────────────────────
        font = "CaskaydiaCove NF";
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        word_wrap = true;
        ellipsize = "end";

        # ── Icons ───────────────────────────────────────────
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 48;

        # ── Behavior ────────────────────────────────────────
        follow = "mouse";
        show_indicators = false;
        sticky_history = true;
        history_length = 20;

        # ── Mouse actions ───────────────────────────────────
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      # ── Urgency levels (Catppuccin Mocha) ─────────────────
      urgency_low = {
        background = "#1e1e2e"; # base
        foreground = "#cdd6f4"; # text
        frame_color = "#a6e3a1"; # green
        timeout = 5;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa"; # blue
        timeout = 10;
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8"; # red
        timeout = 0; # persistent until dismissed
      };

      # ── App-specific rules (optional examples) ────────────
      discord = {
        appname = "discord";
        frame_color = "#cba6f7"; # mauve
      };

      spotify = {
        appname = "Spotify";
        frame_color = "#a6e3a1"; # green
      };

      volume = {
        appname = "volume";
        history_ignore = true;
        timeout = 2;
      };

      screenshot = {
        appname = "hyprshot";
        frame_color = "#f9e2af"; # yellow
        timeout = 3;
      };
    };
  };
}
