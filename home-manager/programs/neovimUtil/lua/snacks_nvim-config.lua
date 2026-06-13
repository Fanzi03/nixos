require("snacks").setup({
	explorer = { 
		enabled = true,
		-- Прописываем клавиши, которые Snacks должен разрешить внутри себя
		keys = {
			-- Открывать Telescope find_files прямо из проводника по вашей кнопке
			["<leader>ff"] = function()
				require("telescope.builtin").find_files()
			end,
		}
	},
	notifier = { enabled = true },
	words    = { enabled = true },

	-- Безопасная конфигурация дешборда для NixOS
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ 
				section = "text", 
				text = { "⚡ NixOS + Neovim Pure Lua Edition ⚡", align = "center" }, 
				padding = 1 
			},
			{ section = "keys", gap = 1, padding = 1 },
		},
	},
})

-- Ваша кнопка проводника
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Открыть проводник" })

