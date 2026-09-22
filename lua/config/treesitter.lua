-- ============================================================
-- Treesitter
-- ============================================================

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "solidity",
    "lua",
    "c",
    "bash",
    "python",
  },

  highlight = {
    enable = true,
  },
})
