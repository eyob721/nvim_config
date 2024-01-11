local function indentation()
  local expandtab = vim.api.nvim_buf_get_option(0, "expandtab")
  local tabstop = vim.api.nvim_buf_get_option(0, "tabstop")

  if expandtab then
    return "spaces: " .. tabstop
  else
    return "tabs: " .. tabstop
  end
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, indentation)
  end,
}
