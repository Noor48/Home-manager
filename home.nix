{ config, lib, pkgs, nixgl, nur, ... }:


{

  imports = [
#    # <catppuccin/modules/home-manager>
    ./themes.nix
    ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nooremf";
  home.homeDirectory = "/home/nooremf";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.


  nixGL.packages = nixgl.packages.${pkgs.system};
nixGL.defaultWrapper = "mesa";
nixGL.installScripts = ["mesa"];

  nix.package = pkgs.nix;
  programs.git = {
    enable = true;
    userName = "Noor";
    userEmail = "nooremf@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

     stylix.enable = true;
     #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
     #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
     #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";


    stylix.fonts = {
        serif = {
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Fonts";
        };

#         noto = {
#           package = pkgs.nerd-fonts.noto;
#           name = "Noto Nerd Fonts";
#         };

        sansSerif = {
          package = pkgs.nerd-fonts.arimo;
          name = "Amiro Nerd fonts";
        };

        monospace = {
          package = pkgs.nerd-fonts.mononoki;
          name = "Mononoki Nerd Fonts";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
#catppuccin.flavor = "mocha";
  #programs.wezterm = {
  #  enable = true;
  #  package = config.lib.nixGL.wrap pkgs.wezterm;
  #};

 # catppuccin.enable = true;

  #programs.zellij.enable = true;
  #programs.yazi.enable = true;

  programs = {
    wezterm = {
        enable = true;
        package = config.lib.nixGL.wrap pkgs.wezterm;

     };

    ghostty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.ghostty;
    };

    kitty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.kitty;
    };

    alacritty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.alacritty;
    };

    foot = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.foot;
    };

      zellij = {
        enable = true;
        package = config.lib.nixGL.wrap pkgs.zellij;

     };

     yazi = {
        enable = true;
        package = config.lib.nixGL.wrap pkgs.yazi;
        settings = {
            manager = {
              ratio = [
                         1
                         4
                         3
              ];
              sort_by = "natural";
              sort_sensitive = true;
              sort_reverse = false;
              sort_dir_first = true;
              linemode = "none";
              show_hidden = true;
              show_symlink = true;
           };

           opener = {
    text = [
      { run = "helix \"$@\""; block = true; }
    ];
  };

        media = [
        {
          run = "mpv \"$@\"";
          desc = "mpv";
          block = true;
        }
      ];

     pdff = [
        { run = "okular \"$@\""; desc = "Okular"; block = true; for = "unix"; }
      ];
           open = {
              # rules = [
             #{mime = ".pdf"; use = [ "pdff" ];}
             #];
           };
      preview = {
         image_filter = "lanczos3";
         image_quality = 90;
         tab_size = 1;
         max_width = 600;
         max_height = 900;
         cache_dir = "";
         ueberzug_scale = 1;
         ueberzug_offset = [
                             0
                             0
                             0
                             0
                           ];
         };

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
        };
      };

     };

    rio = {
        enable = true;
        package = config.lib.nixGL.wrap pkgs.rio;

     };

    helix = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.helix;
    };


    btop = {
      enable = true;
      package = pkgs.btop;
    };
  };
  #catppuccin.zellij.enable = true;
  #catppuccin.zellij.flavor = "mocha";
/*
  catppuccin = {
      zellij = {
          enable = true;
          flavor = "mocha";
      };

      yazi = {
          enable = true;
          flavor = "mocha";
      };

       rio = {
          enable = true;
          flavor = "mocha";
      };


  };*/



  #catppuccin.flavor = "mocha";
  #catppuccin.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

     #oh-my-posh
     #guix
     #ladybird
     #servo
     #ptyxis
     #blackbox-terminal
     #cosmic-term
     #konsole
     #ghostty
     #rioterm
     zoxide
     #peazip
     jq
     poppler
     fd
     ripgrep
     fzf
     imagemagick
     xsel
     #(config.lib.nixGL.wrap helix)
     (config.lib.nixGL.wrap pkgs.rio)
     #zathura
     fcitx5-openbangla-keyboard
     starship
     typst
     utpm
     jujutsu
     #ghostty
     #gcc13
     gfortran
     ncdu
     duff
     ripgrep-all
     #mosh
     lshw
     mtr
     ranger
     eza
     glances
     iotop
     #stats
     #dstack
     #watch
     #progress
     #dig
     dogdns
     #dog
     #tcpdump
     #tshark
     termshark
     #lsof
     #ipcalc
     magic-wormhole
     #procs
     lazydocker
     lazygit
     #rsync
     #rm
     #shred
     moreutils
     #ts
     #errno
     #ifdata
     #vidir
     #vipe
     unp
     #jq
     #taskwarrior3
     #taskwarrior-tui
     asciinema_3
     asciinema-agg
     #fabric-ai
     #russh
     #warpgate
     (config.lib.nixGL.wrap warp-terminal)
     waveterm
     magic-wormhole-rs
     #(config.lib.nixGL.wrap githubPackages.zen-browser)
     
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/sc  reenrc;
    ".bashrc".source = "/home/nooremf/bashrc backup.txt";

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nooremf/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
