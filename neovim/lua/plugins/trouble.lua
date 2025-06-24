return {{
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<Leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc="Diagonstics (Trouble)" },
      { "<Leader>xX", "<cmd>Trouble diagnostics toggle fliter.buf=0<cr>", desc="Buffer Diagnostics (Trouble)" },
    },
}}
