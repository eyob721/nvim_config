-- A snazzy buffer line (tab integration) for Neovim built using lua

return {
  "akinsho/bufferline.nvim",
  lazy = false,
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    -- Pinning and Grouping buffers
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    {
      "<leader>bP",
      "<Cmd>BufferLineGroupClose ungrouped<CR>",
      desc = "Delete non-pinned buffers",
    },

    -- Closing buffers
    {
      "<leader>bo",
      "<Cmd>BufferLineCloseOthers<CR>",
      desc = "Delete other buffers",
    },
    {
      "<leader>br",
      "<Cmd>BufferLineCloseRight<CR>",
      desc = "Delete buffers to the right",
    },
    {
      "<leader>bl",
      "<Cmd>BufferLineCloseLeft<CR>",
      desc = "Delete buffers to the left",
    },

    -- Switching between buffers
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Pre) buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    -- { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    -- { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },

    -- Moving buffers positions on the buffer line
    { "<C-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" } },
    { "<C-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" } },
  },
  opts = {
    options = {
      close_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      separator_style = "slant",
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
