{
pkgs,
lib,
config,
...
}: {
	vim = {
    globals= {
      "loaded_netrw" = 1;
      "loaded_netrwPlugin"=  1;
    };
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
				listMarks = "<leader>h";
				file1 = "<C-j>";
				file2 = "<C-k>";
				file3 = "<C-l>";
				file4 = "<C-;>";
			};
		};
		#autocomplete.blink-cmp.enable=true;
		autocomplete.nvim-cmp = {
			enable =true;
			setupOpts = {
				completion = {
					autocomplete = true; #false
				};
			};
		};

		languages = {
			enableTreesitter = false;

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
			python = {
        enable = true;
        extraDiagnostics.enable = true;
      };
			clang.enable = true;
		};

		keymaps = [
#
#			{
#				key = "<leader>e";
#				mode = "n";
#				silent = true;
#				action = ":Ex<CR>";
#			}

			{
				key = "<leader>bd";
				mode = "n";
				silent = true;
				action = ":bdelete<CR>";
				# delete current buffer
			}
			{
				key = "<leader>e";
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
