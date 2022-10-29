local lsputil = require('lspconfig/util')

local M = {}

local function uses_pipenv()
  return vim.fn.glob(lsputil.path.join(vim.fn.getcwd(), 'Pipfile')) ~= ''
end

local function get_pipenv_virtualenv(stdout)
  handle, pid = vim.loop.spawn(
    'pipenv', 
    {
      args = { '--venv' },
      stdio = { nil, stdout, nill}
    }, 
    function() 
      stdout:read_stop()
      stdout:close()
      handle:close()
    end
  )

  if not handle then
    print('Failed to spawn process:', pid)
    return
  end
end

local function set_virtualenv(err, data)
  if err then
    return
  end
  if data and data ~= '' then
    data = vim.fn.trim(data)
    print('Setting up virtualenv:', data)
    vim.env.VIRTUAL_ENV = data 
    vim.env.PATH = lsputil.path.join(data, '/bin:', vim.env.PATH)
  end
end

function M.setup()
  local stdout = vim.loop.new_pipe(false)

  if uses_pipenv() then
    get_pipenv_virtualenv(stdout)
  end

  vim.loop.read_start(stdout, vim.schedule_wrap(set_virtualenv))
end

return M
