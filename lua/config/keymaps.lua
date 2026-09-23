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

vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>",
	{desc = "Afficher les buffers" })

vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>",
	{ desc = "Fichiers récents" })

vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",
	{ desc = "Symboles du fichier" })

vim.keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>",
	{ desc = "Symboles du projet" })

vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>",
	{ desc = "Diagnostics LSP" })

vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>",
	{ desc = "Git status" })

vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>",
	{ desc = "Git commits" })

vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>",
	{ desc = "Git branches" })

vim.keymap.set("n", "<leader>gB", "<cmd>Telescope git_bcommits<CR>",
	{ desc = "Commits du fichier" })

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
