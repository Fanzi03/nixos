
--local lspconfig = require('lspconfig') --vim.lsp.config() 
local cmp = require('cmp')

-- rust
local capabilities = require('cmp_nvim_lsp').default_capabilities()
--lspconfig.rust_analyzer.setup({ settings})
vim.lsp.config('rust_analyzer', {
	settings ={
		['rust_analyzer'] = {
			completion ={
				enable = false,
			},
		},
	},
})			
vim.lsp.enable('rust_analyzer')

cmp.setup({
 sources = {
  { name = 'nvim_lsp' },
  { name = 'buffer' },
  { name = 'path' },
 },
mapping = {
	['<Tab>'] = cmp.mapping.select_next_item(),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
}
})

--require('colorizer').setup()
require('tokyonight').setup()
vim.cmd.colorscheme "tokyonight"

--numbers
vim.opt.number = true
vim.opt.relativenumber = true

--navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition)       -- Go to definition
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)      -- Go to declaration
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)   -- Go to implementation
vim.keymap.set("n", "gr", vim.lsp.buf.references)       -- Find references

require('jdtls-config')
require('telescope-config')
require('harpoon-config')
require('sql-config')
require('snacks_nvim-config')
require('treesitter-config')


