--[[
=================================================================================
Neovim Debugger: nvim-dap
=================================================================================
To add a debug adapter:
  - Add the debug adapter to the ensure installed table of
    mason-nvim-dap config
      - You can find supported adapters list from
        https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
  - After that add the adapter configurations in nvim-dap config function
      - 2 tables are required for each adapter
          -> adapter: https://github.com/jay-babu/mason-nvim-dap.nvim/tree/main/lua/mason-nvim-dap/mappings/adapters
          -> configuration: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/configurations.lua
      - NOTE: when setting configuration use the filetype name, not the adapter name
              use the configs below as an example
--]]

---@diagnostic disable: redundant-parameter
return {
  "mfussenegger/nvim-dap",
  config = function()
    local Config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    local dap = require("dap")

    -- [[ C and C++ ]] ----------------------------------------------------{{{

    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.exepath("OpenDebugAD7"),
    }

    dap.configurations.cpp = {
      {
        name = "Debug C/C++ file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
      },
      {
        name = "Attach to gdbserver :1234",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = vim.fn.exepath("gdb"),
        cwd = "${workspaceFolder}",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
      },
    }
    dap.configurations.c = dap.configurations.cpp
    -- }}}

    -- [[ Python ]] -------------------------------------------------------{{{

    dap.adapters.python = {
      type = "executable",
      command = vim.fn.exepath("debugpy-adapter"),
    }

    local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        name = "Python: Launch file",
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        cwd = "${workspaceFolder}",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        -- program = "${file}", -- This configuration will launch the current file if used.
        -- venv on Windows uses Scripts instead of bin
        pythonPath = venv_path
            and ((vim.fn.has("win32") == 1 and venv_path .. "/Scripts/python") or venv_path .. "/bin/python")
          or nil,
        console = "integratedTerminal",
      },
    }
    -- }}}
  end,
}
