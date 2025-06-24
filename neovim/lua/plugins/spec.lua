return {
    "airblade/vim-gitgutter",
    "github/copilot.vim",
    { 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' } },
    "junegunn/gv.vim",
    {
      "lervag/vimtex",
      lazy = false,
      init = function()
        vim.g.vimtex_view_method = 'skim'
      end
    },
    "tpope/vim-commentary",
    "tpope/vim-endwise",
    "tpope/vim-fugitive",
    "tpope/vim-sensible",
    "tpope/vim-sleuth",
    "tpope/vim-surround",
    {"nvim-neo-tree/neo-tree.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        }
    },
    {"nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }},
}
