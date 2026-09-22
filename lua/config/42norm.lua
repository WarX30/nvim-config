-- ============================================================
-- Norme 42
-- ============================================================

local norm = require("42norm")

norm.setup({
  format_on_save = false,
  header_on_save = false,
  lint_on_change = true,
  timeout = 3000,
  ignore = {},
})


-- ============================================================
-- Suppression de l'autocommande automatique du header
-- ============================================================

for _, au in ipairs(
  vim.api.nvim_get_autocmds({
    event = "BufWritePre",
    pattern = "*",
  })
) do
  if au.callback == require("42norm.header").update then
    vim.api.nvim_del_autocmd(au.id)
  end
end
