{
pkgs,
lib,
...
}: {
	vim = {
		theme = {
			enable = true;
			name = "tokyonight";
			style = "night";
		};
		options = {
			shiftwidth = 2;
			tabstop = 2;
			expandtab = true;
			smartindent = true;
			autoindent = true;
			cindent = false;
		};
		visuals = {
			indent-blankline.enable = true;
		};
		treesitter = {
			enable = false;
			indent.enable = true;
			highlight.enable = true;
		};

		statusline.lualine.enable = true;
		lsp = {
			enable = true;
			mappings = {
				goToDefinition = "gd";
				goToDeclaration = "gD";
			};
		};
		utility.snacks-nvim = {
			enable = true;
			#mappings = {};
		};

		telescope.enable = true;
		navigation.harpoon = {
			enable = true;

			mappings = {
				markFile = "<leader>a";
				listMarks = "<leader>e";
				file1 = "<C-j>";
				file2 = "<C-k>";
				file3 = "<C-l>";
				file4 = "<C-;>";
			};
		};
		autocomplete.nvim-cmp = {
			enable = true;
			setupOpts = {
				completion = {
					autocomplete = false;
				};
			};
		};

		languages = {
			enableTreesitter = false;
			enableLSP = true;

			nix = {
				enable = true;
			};
			rust.enable = true;
			java = {
				enable = true;
				lsp = {
					enable = true;
				};
			};
			bash.enable = true;
			ts.enable = true;
			python.enable = true;
			clang.enable = true;
		};

		keymaps = [
			{
				key = "<leader>cd";
				mode = "n";
				silent = true;
				action = ":Ex<CR>";
			}

			{
				key = "<leader>bd";
				mode = "n";
				silent = true;
				action = ":bdelete<CR>";
				# delete current buffer
			}
			{
				key = "<C-e>";
				mode = "n";
				silent = true;
				action = ":lua Snacks.explorer()<CR>";
			}
		];

    #nvim-jdtls for go to definition !!!!!
		extraPlugins = with pkgs.vimPlugins; {
			nvim-jdtls = {
				package = nvim-jdtls;
			};
		};

	};
}
