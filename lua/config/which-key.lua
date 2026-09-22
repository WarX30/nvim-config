-- ============================================================
-- Which-Key
-- ============================================================

vim.o.timeout = true
vim.o.timeoutlen = 300

local wk = require("which-key")

wk.setup({
  preset = "modern",
})

wk.add({
  {
    "<leader>f",
    group = "Recherche",
    icon = "🔍",
  },
  {
    "<leader>n",
    group = "42 Norme",
    icon = "🎓",
  },
  {
    "<leader>e",
    desc = "Ouvrir/Fermer l'explorateur",
    icon = "📁",
  },
})
