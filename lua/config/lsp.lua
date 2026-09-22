-- ============================================================
-- Language Server Protocol
-- ============================================================

-- ============================================================
-- Mason
-- ============================================================

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "bashls",
    "lua_ls",
    "pyright",
    "solidity_ls_nomicfoundation",
  },
})


-- ============================================================
-- LSP capabilities
-- ============================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()


-- ============================================================
-- C / C++ — clangd
-- ============================================================

vim.lsp.config("clangd", {
  capabilities = capabilities,
})

vim.lsp.enable("clangd")


-- ============================================================
-- Solidity LSP
-- ============================================================

vim.lsp.config("solidity_ls_nomicfoundation", {
  cmd = {
    "nomicfoundation-solidity-language-server",
    "--stdio",
  },

  filetypes = {
    "solidity",
  },

  root_markers = {
    "hardhat.config.js",
    "hardhat.config.ts",
    "foundry.toml",
    "remappings.txt",
    "truffle.js",
    "truffle-config.js",
    ".git",
    "package.json",
  },

  capabilities = capabilities,
})

vim.lsp.enable("solidity_ls_nomicfoundation")
