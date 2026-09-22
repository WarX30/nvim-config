-- ============================================================
-- Init.lua Neovim 0.11 (42 ready)
-- ============================================================

-- Installer lazy.nvim si absent
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- Plugins
-- ============================================================
require("lazy").setup({

  -- Thème
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- File explorer + icons
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Treesitter (coloration syntaxique, notamment pour Solidity)
  -- Nouvelle API (branche "main", réécriture 1.0 de nvim-treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "solidity", "lua", "c", "bash", "python" })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "solidity", "lua", "c", "bash", "python" },
        callback = function()
          pcall(vim.treesitter.start())
        end,
      })
    end,
  },

  -- Autocomplétion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- Statusline
  "nvim-lualine/lualine.nvim",

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- 42norm
  {
    "MoulatiMehdi/42norm.nvim",
    config = function()
      local norm = require("42norm")
      local header = require("42norm.header")

      norm.setup({
        format_on_save = false,
        header_on_save = false, -- on gère nous-même via <F1>
        lint_on_change = true,
        timeout = 3000,
        ignore = {},
      })

      -- Retire l'autocommand BufWritePre "*" que le plugin enregistre
      -- inconditionnellement au chargement du module (bug : ignore le filetype)
      for _, au in ipairs(vim.api.nvim_get_autocmds({ event = "BufWritePre", pattern = "*" })) do
        if au.callback == header.update then
          vim.api.nvim_del_autocmd(au.id)
        end
      end

      vim.keymap.set("n", "<F1>", header.stdheader, { silent = true, desc = "Insert/update 42 header" })
      vim.keymap.set("n", "<leader>nc", norm.check_norms, { silent = true })
      vim.keymap.set("n", "<leader>nf", norm.format, { silent = true })
    end,
  },
})

-- ============================================================
-- Filetypes additionnels
-- ============================================================
vim.filetype.add({ extension = { sol = "solidity" } })

-- ============================================================
-- Options de base
-- ============================================================
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.wrap = false

-- ============================================================
-- Tabs (Norme 42)
-- ============================================================
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

-- ============================================================
-- Mappings
-- ============================================================
local map = vim.keymap.set
map("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
map("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })

-- ============================================================
-- Thème
-- ============================================================
require("catppuccin").setup({
  integrations = {
    lualine = true,
  },
})

vim.cmd.colorscheme("catppuccin")

-- ============================================================
-- NvimTree
-- ============================================================
require("nvim-tree").setup({
  renderer = {
    icons = {
      show = { file = true, folder = true, folder_arrow = true, git = true },
    },
  },
})

-- ============================================================
-- Mason + LSP
-- ============================================================
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "bashls", "lua_ls", "pyright", "solidity_ls_nomicfoundation" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.start({
	name = "clangd",
	cmd = { "clangd" };
	capabilities = capabilities,
})

-- Solidity (nécessite : npm install -g @nomicfoundation/solidity-language-server
-- ou :MasonInstall solidity_ls_nomicfoundation)
vim.lsp.config("solidity_ls_nomicfoundation", {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_markers = {
    "hardhat.config.js", "hardhat.config.ts",
    "foundry.toml", "remappings.txt",
    "truffle.js", "truffle-config.js",
    ".git", "package.json",
  },
  capabilities = capabilities,
})
vim.lsp.enable("solidity_ls_nomicfoundation")

-- ============================================================
-- Autocompletion
-- ============================================================
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "luasnip" },
  },
})

-- ============================================================
-- Lualine
-- ============================================================
require("lualine").setup({
  options = { theme = "catppuccin" },
})
