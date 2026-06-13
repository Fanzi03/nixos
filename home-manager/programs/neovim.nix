{ config, pkgs, ... }:

{
	xdg.configFile."nvim".source = ./neovimUtil;
	#xdg.configFile."nvim/lua/jdtls.lua".text = import ./neovimUtil/lua/jdtls.nix { inherit pkgs; };

	programs.neovim = {
		enable = true;
		defaultEditor = true; plugins = with pkgs.vimPlugins;[
			telescope-nvim
			coc-rust-analyzer
			(nvim-treesitter.withPlugins (p: [
				p.java
				p.lua
				p.javascript
				p.python
				p.nix
				p.kotlin
				p.html
				p.css
				p.sql
				p.rust
			]))
			snacks-nvim
			nvim-colorizer-lua
			tokyonight-nvim
			harpoon2
			nvim-lspconfig
			nvim-jdtls
			nvim-cmp
			cmp-nvim-lsp
			cmp-buffer
			cmp-path
		];

		extraPackages = with pkgs; [
			jdt-language-server
			ripgrep
			lombok
			fd
			wl-clipboard
			sqls

			#compali
			gcc          
			nodejs       
			tree-sitter  
		];


		extraLuaConfig = ''
		'';
	};	
}
