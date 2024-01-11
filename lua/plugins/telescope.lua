return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      mappings = {
        n = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
  },
}
