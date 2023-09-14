{ config, pkgs, ... }:

{
  # I am testing this on my LattePanda while working on the embci project
  home.username = "embci";
  home.homeDirectory = "/home/embci";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
    # The plan is to move as many of the packages as possible from the system
    # configuration in here
  ];

  home.file =
    let
      wallpapers_repo = pkgs.fetchFromGitHub {
        owner = "Gingeh";
        repo = "wallpapers";
        rev = "2530dba";
        sha256 = "FiilS+t6QszTsnaIFVRRC8pQ6oTcv6qvKMf9cD5AoBQ=";
      };
      configfiles_repo = pkgs.fetchFromGitHub {
        owner = "Daedrus";
        repo = "configfiles";
        rev = "5b81c12";
        sha256 = "GC3RWLV3v13mLHqesqlnmTedK2oi/+UwwL28CU2FXm8=";
      };
    in {
      # Wallpaper
      ".wallpapers/bkg5.png".source =
        wallpapers_repo + "/solids/bkg5.png";

      # i3, i3 color scheme and i3status
      ".config/i3/config".source =
        configfiles_repo + "/i3/config";
      ".config/i3/catppuccin-mocha".source =
        configfiles_repo + "/i3/catppuccin-mocha";
      ".config/i3status/config".source =
        configfiles_repo + "/i3status/config";

      # Alacritty
      ".config/alacritty/alacritty.yml".source =
        configfiles_repo + "/alacritty/alacritty.yml";

      # PowerLevel10k
      ".p10k.zsh".source =
        configfiles_repo + "/p10k/.p10k.zsh";

      # Neovim
      #
      # Separating the nvim configs like this causes the nvim folder to be
      # a writeable folder instead of a symlink. This allows lazy.nvim to
      # create the lazy-lock.json file in the nvim folder without any issues.
      ".config/nvim/init.lua".source =
        configfiles_repo + "/nvim/init.lua";
      ".config/nvim/lua/".source =
        configfiles_repo + "/nvim/lua/";
    };

  # Let nix manage picom since I'm only interested in rounded corners
  services.picom = {
    enable = true;
    settings = {
      corner-radius = 12.0;
      rounded-corners-exclude = [
        "class_g = 'i3bar'"
        "class_g = 'firefox'"
      ];
    };
  };

  # zsh and oh-my-zsh are currently easier to manage from nix since my
  # configuration isn't that complex; nevertheless, even with a simple config
  # like this, one can see the limitations of doing it this way: options (and
  # who knows what other things) might be missing from the nixos module.
  programs.zsh = {
    enable = true;
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    oh-my-zsh = {
      plugins = [
        "z"
	"git"
	"fzf"
	"colored-man-pages"
      ];
      enable = true;
    };
    plugins = [
      {
        name = "powerlevel10k";
	src = pkgs.zsh-powerlevel10k;
	file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    shellAliases = {
      sudo = "sudo "; # https://wiki.archlinux.org/title/Sudo#Passing_aliases
      vi = "nvim";
      vim = "nvim";
    };
    enableSyntaxHighlighting = true;

    # Uncomment this after upgrading to a newer home-manager version
    # This option is not available in 23.05 but is available in master
    # history.ignoreAllDups = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    # Unfortunately this variable seems to be set _after_ i3 initializes
    # if left in this spot so the terminal still defaults to xterm.
    # Try to fix it once the i3 setup is moved in this file instead of the
    # system configuration file.
    TERMINAL = "alacritty";
    FZF_DEFAULT_OPTS =" \
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
