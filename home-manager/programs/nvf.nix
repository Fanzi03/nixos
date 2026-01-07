{pkgs, lib, ...}:

{
        vim = {
                theme ={
                        enable = true;
                        name = "tokyonight";
                        style = "night";
                };

                statusline.lualine.enable = true;
                lsp = {
                        enable = true;
                        mappings = {
                                goToDefinition = "gd";
                                goToDeclaration = "gD";
                        };
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
                        enableTreesitter = true;

                        nix.enable = true;
                        rust.enable = true;
                        java.enable = true;
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
                ];
        };
}
