require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
        }
	use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
	local startify = require('alpha.themes.startify')
	startify.section.bottom_buttons.val = {
		startify.button("f", "fish config", ":e ~/.config/fish/config.fish"),
		startify.button("v", "neovim config", ":e ~/.config/nvim/init.lua"),
		startify.button("p", "kitty config", ":e ~/.config/kitty/kitty.conf"),
		startify.button("n", "notes", ":e ~/.notes/"),
		startify.button("t", "todo", ":e ~/.todo/"),
	
	}
    end
}
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
}
	use 'nvim-lua/plenary.nvim'
	use 'BurntSushi/ripgrep'
	use 'preservim/nerdtree'
end)


require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "javascript", "html" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'


local lsp_installer = require'nvim-lsp-installer'
lsp_installer.on_server_ready(function(server)
	local opts = {}
	server:setup(opts)
end)


local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }


local function nkeymap(key, map)
	keymap('n', key, map, opts)
end

nkeymap('<c-l>', ':set relativenumber<cr>')
nkeymap('<c-n>', ':Alpha<cr>')
nkeymap('<c-e>', ':NERDTreeToggle<cr>')
nkeymap('<c-t>', ':Telescope<cr>')
nkeymap('<c-s>', ':source %<cr>')
nkeymap('gd', ':lua vim.lsp.buf.definition()<cr>')
nkeymap('gD', ':lua vim.lsp.buf.declaration()<cr>')
nkeymap('gi', ':lua vim.lsp.buf.implementation()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.document_symbol()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')
nkeymap('gr', ':lua vim.lsp.buf.references()<cr>')
nkeymap('gt', ':lua vim.lsp.buf.type_definition()<cr>')
nkeymap('K', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<c-k>', ':lua vim.lsp.buf.signature_help()<cr>')
nkeymap('<leader>af', ':lua vim.lsp.buf.code_action()<cr>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')


