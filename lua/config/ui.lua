-- ============================================================
-- Interface utilisateur
-- ============================================================


-- ============================================================
-- Thème — Catppuccin
-- ============================================================

require("catppuccin").setup({
  integrations = {
    lualine = true,
  },
})

vim.cmd.colorscheme("catppuccin")


-- ============================================================
-- Explorateur — NvimTree
-- ============================================================

require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
})


-- ============================================================
-- Statusline — Lualine
-- ============================================================

require("lualine").setup({
  options = {
    theme = "catppuccin-nvim",
  },
})
