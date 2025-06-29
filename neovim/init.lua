require("config.lazy")

-- Global Settings
vim.cmd [[
    set modifiable
    set nocompatible
    filetype plugin on
    set encoding=utf-8
    set fileencoding=utf-8
    set clipboard=unnamed
    syntax on
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab
    set shiftround
    set number
    set belloff=all
    set mouse=a
    set hidden
    set ignorecase
    set smartcase
    set undofile
    set termguicolors

    hi normal guibg=NONE
]]

-- Remove Trailing Whitespace
vim.cmd [[
    autocmd BufWritePre * :%s/\s\+$//e
]]

-- VimTex
vim.cmd [[
    let g:tex_flavor='latex'
    let g:vimtex_quickfix_mode=0
]]

-- Lualine
require('lualine').setup {
    options = { theme='solarized_dark' }
}
vim.opt.showmode = false

-- Keymaps
vim.cmd [[
    nnoremap <C-p> :Files<CR>
    nnoremap <silent> <C-b> :Buffers<CR>
    nnoremap <C-f> :Rg<CR>

    map <C-j> :tabp<CR>
    map <C-l> :tabn<CR>
    map <C-k> :tabnew<CR>

    map <C-n> :Neotree toggle<CR>
]]

--- LSP Setup
vim.opt.signcolumn = 'yes'
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { "lua_ls", "pyright", "rust_analyzer" },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})


--- Diagnostic config
vim.diagnostic.config({
  virtual_text = false,
  signs = true,  -- You can keep the signs in the gutter if you still want them
  underline = true,  -- Optional: keep underlining of errors and warnings
  severity_sort = true,  -- Optional: show higher severity diagnostics first
  float = {
    border = "rounded",     -- Optional: add a border around the floating window
    source = "if_many",     -- Show the source of the diagnostic (e.g., LSP server)
    header = false,         -- Optional: you can hide the header if you want
  },
})
-- Enable hover to show diagnostics
vim.o.updatetime = 250  -- Optional: tweak update time for diagnostics
vim.cmd [[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focusable = false })
]]

---
-- Autocompletion config
---
local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

