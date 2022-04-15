local lang = {}
local conf = require("modules.lang.config")
local path = plugin_folder()

lang["nvim-treesitter/nvim-treesitter"] = {
  opt = true,
  config = conf.nvim_treesitter,
  run = function() vim.cmd("TSUpdate") end,
}

lang['danymat/neogen'] = {
  opt = true,
  config = function()
    require("neogen").setup({enabled = true})
  end
}

lang['ThePrimeagen/refactoring.nvim'] = {
  opt = true,
  config = conf.refactor
}

lang["nanotee/sqls.nvim"] = {ft = {"sql", "pgsql"}, setup = conf.sqls, opt = true}

lang[path .. "go.nvim"] = {ft = {"go", "gomod"}, config = conf.go}

lang[path .. "navigator.lua"] = {
  requires = {path .. "guihua.lua", run = 'cd lua/fzy && make'},
  config = conf.navigator,
  opt = true
}

lang["mfussenegger/nvim-dap"] = {diable = true, config = conf.dap, opt = true} -- cmd = "Luadev",

lang["JoosepAlviste/nvim-ts-context-commentstring"] = {opt = true}

lang["rcarriga/nvim-dap-ui"] = {
  -- requires = {"mfussenegger/nvim-dap"},
  disable = true,
  config = conf.dapui,
  cmd = "Luadev",
  opt = true
}

lang["theHamsta/nvim-dap-virtual-text"] = {disable = true, opt = true, cmd = "Luadev"}

lang["jbyuki/one-small-step-for-vimkind"] = {disable = true, opt = true, ft = {"lua"}}

lang["mfussenegger/nvim-dap-python"] = {disable = true, ft = {"python"}}

lang["p00f/nvim-ts-rainbow"] = {
  opt = true,
  after = "nvim-treesitter",
  -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  -- cmd = 'Rainbow',
  config = function()
    require"nvim-treesitter.configs".setup {rainbow = {enable = true, extended_mode = true}}
  end
}

lang['folke/trouble.nvim'] = {
  cmd = {'Trouble', 'TroubleToggle'},
  config = function()
    require("trouble").setup {}
  end
}

lang['jose-elias-alvarez/null-ls.nvim'] = {opt = true, config = require"modules.lang.null-ls".config}

return lang
