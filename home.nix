{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];
  nixpkgs.config.allowUnfree = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jcsan";
  home.homeDirectory = "/home/jcsan";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # Only change this value if doing a fresh install of NixOS
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    # (pkgs.callPackage ./osu-lazer.nix {})
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  home.sessionPath = [
    # for pnpm to work
    "$HOME/.pnpm"
  ];
  services.mpd-mpris.enable = true;
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      documents = "/media/sorairo/Docs";
      videos = "/media/sorairo/Videos";
      music = "/media/sorairo/Music";
      pictures = "/media/sorairo/Pics";
      download = "/media/sorairo/Downloads";
    };

    mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = "firefox.desktop";
        "inode/directory" = "nautilus.desktop";
        "image/*" = "org.gnome.gThumb.desktop";
        "image/webp" = "org.gnome.gThumb.desktop";
        "image/png" = "org.gnome.gThumb.desktop";
        "image/jpeg" = "org.gnome.gThumb.desktop";
        "image/gif" = "org.gnome.gThumb.desktop";
        "image/jpg" = "org.gnome.gThumb.desktop";
        "video/*" = "vlc.desktop";
        "audio/*" = "vlc.desktop";
      };

      defaultApplications = {
        "text/plain" = "org.gnome.TextEditor.desktop";
        "text/*" = "org.gnome.TextEditor.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
        "image/*" = "org.gnome.gThumb.desktop";
        "image/webp" = "org.gnome.gThumb.desktop";
        "image/png" = "org.gnome.gThumb.desktop";
        "image/jpeg" = "org.gnome.gThumb.desktop";
        "image/gif" = "org.gnome.gThumb.desktop";
        "image/jpg" = "org.gnome.gThumb.desktop";
        "video/*" = "vlc.desktop";
        "audio/*" = "vlc.desktop";
      };
    };
  };
  /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk3.bookmarks = [
      "file:///media/sorairo/Light%20Novels"
      "file://${config.home.homeDirectory}/code"
      "file://${config.home.homeDirectory}/.config/nix-conf"
      "file:///media/sorairo/School"
    ];
  };
  # Prefer dark theme
  # dconf = {
  #   enable = true;
  #   settings."org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
    };
  };
  programs.git = {
    enable = true;
    userName = "Jean Carlo San Juan";
    userEmail = "sanjuan.jeancarlo@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
      ac = "commit -am";
      uncommit = "reset HEAD~1";
      recommit = "commit --amend --no-edit";
      edit = "commit --amend";
      undo = "uncommit";
      redo = "recommit";
    };
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch";
    };
    history.size = 15000;
    history.path = "${config.home.homeDirectory}/zsh/history";
    initExtra = ''
      # pass
      bindkey '^H' backward-kill-word
    '';
  };
  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka";
    };
    settings = {
      enabled_layouts = "tall:bias=50;full_size=1;mirrored=false";
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+f>2" = "set_font_size 20";
      "ctrl+f5" = "launch --location=hsplit";
      "ctrl+f6" = "launch --location=vsplit";
      "ctrl+f4" = "launch --location=split";
      "ctrl+f7" = "layout_action rotate";
      "ctrl+left" = "neighboring_window left";
      "ctrl+right" = "neighboring_window right";
      "ctrl+up" = "neighboring_window up";
      "ctrl+down" = "neighboring_window down";
    };
  };
  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.wlrobs ];
  };
  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    # .override {
    #   plugins = [
    #     inputs.rofi-vscode-mode.packages.x86_64-linux.default
    #   ];
    # };
    # modi: 
    extraConfig = {
      modi = "drun,run,window,ssh";
    };
  };

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   # ...
  #   plugins = [
  #     inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
  #     # ...
  #   ];
  # };
}
