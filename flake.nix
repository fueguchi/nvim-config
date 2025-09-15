{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    alejandra.url = "github:kamadorueda/alejandra";
    
    vim-maximizer = {
      url = "github:szw/vim-maximizer";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, ... } @inputs: 
    let
      supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in {
      packages = forAllSystems (system: 
        let
          pkgs = import nixpkgs { inherit system; };
          
          vim-maximizer = pkgs.vimUtils.buildVimPlugin {
            pname = "vim-maximizer";
            version = inputs.vim-maximizer.lastModifiedDate;
            src = inputs.vim-maximizer;
          };

          bins = with pkgs; [
            # Tools
            tree-sitter
            gnumake
            fd
            fzf
            ripgrep
            wget
            git
            ghostscript
            lazygit
            sqlite
            imagemagick
            nodejs
            gcc # for compiling tree-sitter parsers, etc.
            
            # Language Tooling
            cargo
            texlive.combined.scheme-basic
            #lua54Packages.lua
            
            # LSPs & Formatters
            nil # nix
            inputs.alejandra.defaultPackage.${system}
            
            stylua # lua
            lua-language-server
            
            pyright # python
            black
            isort
            
            clang-tools # C/C++
            glib
            python3
            mermaid-cli
          ];
          
          plugins = with pkgs.vimPlugins; [
            nvim-lspconfig
            plenary-nvim
            telescope-nvim
            bufferline-nvim
            nvim-cmp
            nvim-autopairs
            todo-comments-nvim
            nvim-treesitter
            trouble-nvim
            which-key-nvim
            nvim-surround
            substitute-nvim
            snacks-nvim
            nvim-notify
            (cord-nvim.overrideAttrs (oldAttrs: {
              passthru.tests.require-check.enable = false;
            }))
            conform-nvim
            indent-blankline-nvim
            nvim-ts-context-commentstring
            comment-nvim
            alpha-nvim
            vim-tmux-navigator
            cmp-buffer
            cmp-path
            luasnip
            cmp_luasnip
            friendly-snippets
            lspkind-nvim
            nvim-tree-lua
            telescope-fzf-native-nvim
            nvim-ts-autotag
            nvim-lspconfig
            mason-nvim
            mason-lspconfig-nvim
            none-ls-nvim
            cmp-nvim-lsp
            neodev-nvim
            nvim-lsp-file-operations
          ];
          
        in
        {
          default = pkgs.neovim.override {
            vimAlias = true;

            configure = {
              customRC = ''
                " just want to make my neovim plugins being managed by nix when using NixOS
              '';
              
              packages.myPlugins = with pkgs.vimPlugins; {
                start = plugins;
              };

              extraPackages = bins ++ [ vim-maximizer ];
            };
          };
        }
      );
    };
}