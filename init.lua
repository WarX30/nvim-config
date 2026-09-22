-- ============================================================
-- Init.lua — Neovim 0.11 (42 ready)
-- ============================================================


-- ============================================================
-- Leader
-- ============================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- ============================================================
-- Configuration générale
-- ============================================================

require("config.options")
require("config.keymaps")


-- ============================================================
-- Lazy.nvim
-- ============================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


-- ============================================================
-- Plugins
-- ============================================================

require("lazy").setup({

  -- ==========================================================
  -- Thème
  -- ==========================================================

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },


  -- ==========================================================
  -- Explorateur de fichiers + icônes
  -- ==========================================================

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },


  -- ==========================================================
  -- LSP
  -- ==========================================================

  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",


  -- ==========================================================
  -- Treesitter
  -- ==========================================================

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",

    config = function()
      require("config.treesitter")
    end,
  },


  -- ==========================================================
  -- Autocomplétion
  -- ==========================================================

  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",


  -- ==========================================================
  -- Statusline
  -- ==========================================================

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "catppuccin/nvim",
    },
  },


  -- ==========================================================
  -- Telescope
  -- ==========================================================

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },


  -- ==========================================================
  -- Norme 42
  -- ==========================================================

  {
    "MoulatiMehdi/42norm.nvim",

    config = function()
      require("config.42norm")
    end,
  },


  -- ==========================================================
  -- Commentaires
  -- ==========================================================

  {
    "numToStr/Comment.nvim",

    config = function()
      require("config.comment")
    end,
  },


  -- ==========================================================
  -- Which-Key
  -- ==========================================================

  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    config = function()
      require("config.which-key")
    end,
  },
})


-- ============================================================
-- Autocomplétion
-- ============================================================

require("config.completion")


-- ============================================================
-- LSP
-- ============================================================

require("config.lsp")


-- ============================================================
-- Interface utilisateur
-- ============================================================

require("config.ui")


-- ============================================================
-- Filetypes additionnels
-- ============================================================

vim.filetype.add({
  extension = {
    sol = "solidity",
  },
})
