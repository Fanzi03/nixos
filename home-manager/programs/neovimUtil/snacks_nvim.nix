''
	local snacks = require('snacks')
	snacks.setup({
	  bigfile = { enabled = true },
	  dashboard = {
	    enabled = true,
	    sections = {
	      { section = "header" },
	      { section = "keys", gap = 1, padding = 1 },
	      -- Секция "startup" удалена, так как она вызывает ошибку без lazy.nvim
	      { section = "recent_files", indent = 2, padding = 1 },
	      { section = "footer" },
	    },
	  },
	  explorer = { enabled = true },
	  indent = { enabled = true },
	  input = { enabled = true },
	  notifier = {
	    enabled = true,
	    timeout = 3000,
	  },
	  picker = { enabled = true },
	  quickfile = { enabled = true },
	  scope = { enabled = true },
	  scroll = { enabled = true },
	  statuscolumn = { enabled = true },
	  words = { enabled = true },
	  styles = {
	    notification = {
	       -- wo = { wrap = true } 
	    }
	  }
	})

	vim.keymap.set("n", "<C-e>", function() Snacks.explorer() end) -- explorer
''          
























