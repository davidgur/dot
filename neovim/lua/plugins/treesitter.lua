return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "latex", "rust", "markdown" },
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "latex" },
                additional_vim_regex_highlighting = { "latex" },
            },
            indent = { enable = true },
        })
        end
    }
}
