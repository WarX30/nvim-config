-- ============================================================
-- Options générales de Neovim
-- ============================================================

--[[
number         → affiche les numéros de ligne
relativenumber → affiche les numéros relatifs
termguicolors  → permet aux thèmes d'utiliser les vraies couleurs
wrap           → empêche les longues lignes de revenir à la ligne
]]

-- Numéros de lignes
vim.o.number = true
vim.o.relativenumber = true

-- Affichage
vim.o.termguicolors = true
vim.o.wrap = false

-- ============================================================
-- Indentation — Norme 42
-- ============================================================

-- Utiliser de vraies tabulations
vim.opt.expandtab = false

-- Une tabulation = 4 colonnes
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Indentation automatique
vim.opt.smartindent = true
