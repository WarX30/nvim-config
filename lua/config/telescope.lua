-- ============================================================
-- Telescope
-- ============================================================

local telescope = require("telescope")

telescope.setup({
  defaults = {
    layout_strategy = "horizontal",

    layout_config = {
      width = 0.9,
      height = 0.8,
      preview_width = 0.5,
    },

	mappings = {
	  i = {
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
	  },
	},

	preview = {
	  hide_on_startup = false,
	},
  },
})
