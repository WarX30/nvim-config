-- ============================================================
-- Raccourcis clavier
-- ============================================================

-- Explorateur de fichiers
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>",
	{ desc = "Ouvrir/Fermer l'explorateur" })

-- Recherche avec Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>",
	{ desc = "Rechercher un fichier" })

vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",
	{ desc = "Rechercher dans les fichiers" })

-- 42 Norm
vim.keymap.set("n", "<F1>", function()
	require("42norm.header").stdheader()
end, { desc = "Ajouter/actualiser le header 42" })

vim.keymap.set("n", "<leader>nc", function()
	require("42norm").check_norms()
end, { desc = "Vérifier la Norme 42" })

vim.keymap.set("n", "<leader>nf", function()
	require("42norm").format()
end, { desc = "Formater selon la Norme 42" })
