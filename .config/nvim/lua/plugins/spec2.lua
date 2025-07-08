return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "lua", "rust", "python" },
        highlight = { enable = true, },
        indent = {enable = true,},
      }
    end
  }
