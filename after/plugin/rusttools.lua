-- ~/.local/bin/codelldb/extension/adapter/codelldb
local dap = require('dap')

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/home/kasperw/.local/bin/codelldb/extension/adapter/codelldb',
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
-- --/home/kasperw/.local/bin/codelldb/extension/adapter
--
-- local extension_path = vim.env.HOME .. '/home/kasperw/.local/bin/codelldb/extension/'
-- local codelldb_path = extension_path .. 'adapter/codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
--
-- local opts = {
--     -- ... other configs
--     dap = {
--         adapter = require('rust-tools.dap').get_codelldb_adapter(
--             codelldb_path, liblldb_path)
--     }
-- }
--
-- -- Normal setup
-- require('rust-tools').setup(opts)
--
--
---For the heroes who want to use it
---@param codelldb_path string
---@param liblldb_path string
--function M.get_codelldb_adapter(codelldb_path, liblldb_path)
--  return {
--    type = "server",
--    port = "${port}",
--    host = "127.0.0.1",
--    executable = {
--      command = codelldb_path,
--      args = { "--liblldb", liblldb_path, "--port", "${port}" },
--    },
--  }
--end

local function setup_adapter()
  local dap = require("dap")
  dap.adapters.rt_lldb = rt.config.options.dap.adapter
end

local function get_cargo_args_from_runnables_args(runnable_args)
  local cargo_args = runnable_args.cargoArgs

  table.insert(cargo_args, "--message-format=json")

  for _, value in ipairs(runnable_args.cargoExtraArgs) do
    table.insert(cargo_args, value)
  end

  return cargo_args
end

local function scheduled_error(err)
  vim.schedule(function()
    vim.notify(err, vim.log.levels.ERROR)
  end)
end

function StartRust(args)
  if not pcall(require, "dap") then
    scheduled_error("nvim-dap not found.")
    return
  end

  if not pcall(require, "plenary.job") then
    scheduled_error("plenary not found.")
    return
  end

  local dap = require("dap")
  local Job = require("plenary.job")

  --local cargo_args = get_cargo_args_from_runnables_args(args)

  vim.notify(
    "Compiling a debug build for debugging. This might take some time..."
  )

  Job
      :new({
        command = "cargo",
        args = { "build --build-plan -Z unstable-options" },
        cwd = args.workspaceRoot,
        on_exit = function(j, code)
          print(code)
          print(vim.inspect(j:result()))
          if code and code > 0 then
            scheduled_error(
              "An error occurred while compiling. Please fix all compilation issues and try again."
            )
          end

          vim.schedule(function()
            for _, value in pairs(j:result()) do
              local json = vim.fn.json_decode(value)
              if type(json) == "table"
                  and json.executable ~= vim.NIL
                  and json.executable ~= nil
              then
                local dap_config = {
                  name = "Rust tools debug",
                  type = "rt_lldb",
                  request = "launch",
                  program = json.executable,
                  args = args.executableArgs or {},
                  cwd = args.workspaceRoot,
                  stopOnEntry = false,

                  -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                  --
                  --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                  --
                  -- Otherwise you might get the following error:
                  --
                  --    Error on launch: Failed to attach to the target process
                  --
                  -- But you should be aware of the implications:
                  -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                  runInTerminal = false,
                }
                dap.run(dap_config)
                break
              end
            end
          end)
        end,
      })
      :start()
end
