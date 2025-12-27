{pkgs, lib, ...}:

{
        vim = {
                theme ={
                        enable = true;
                        name = "tokyonight";
                        style = "night";
                };

                statusline.lualine.enable = true;
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
                autocomplete.nvim-cmp.enable = true;

                languages = {
                        enableLSP = true;
                        enableTreesitter = true;

                        nix.enable = true;
                        rust.enable = true;
                        java.enable = true;
                        bash.enable = true;
                        #js.enable = true;
                };

                keymaps = [
                        {
                                key = "<leader>cd";
                                mode = "n";
                                silent = true;
                                action = ":Ex<CR>";
                        }
                ];
        };
}
