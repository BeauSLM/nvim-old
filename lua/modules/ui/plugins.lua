local ui = {}
local conf = require("modules.ui.config")

--
local winwidth = function()
  return vim.api.nvim_call_function("winwidth", {0})
end

ui["kyazdani42/nvim-web-devicons"] = {}

ui["windwp/windline.nvim"] = {
  disable = true,
  event = "UIEnter",
  config = conf.windline,
  -- requires = {'kyazdani42/nvim-web-devicons'},
  opt = true
}

ui["lambdalisue/glyph-palette.vim"] = {}

ui["akinsho/bufferline.nvim"] = {
  disable = true,
  config = conf.nvim_bufferline,
  event = "UIEnter",
  diagnostics_update_in_insert = false,
  -- after = {"aurora"}
  -- requires = {'kyazdani42/nvim-web-devicons'}
  opt = true
}
-- 'luaromgrk/barbar.nvim'
-- ui['romgrk/barbar.nvim'] = {
--   config = conf.barbar,
--   requires = {'kyazdani42/nvim-web-devicons'}
-- }
--
-- not so useful...
-- ui["wfxr/minimap.vim"] = {
--   run = ":!cargo install --locked code-minimap",
--   keys = {"<F14>"},
--   cmd = {"Minimap", "MinimapToggle"},
--   setup = conf.minimap
-- }

ui["kyazdani42/nvim-tree.lua"] = {
  disable = true,
  cmd = {"NvimTreeToggle", "NvimTreeOpen"},
  -- requires = {'kyazdani42/nvim-web-devicons'},
  setup = conf.nvim_tree_setup,
  config = conf.nvim_tree
}

-- ui['ms-jpq/chadtree'] = {
--   run = 'python3 -m chadtree deps',
--   branch = 'chad',
--   setup = function()
--     vim.g.chadtree_settings = {['theme.text_colour_set'] = 'nerdtree_syntax_dark'}
--   end
-- }

ui["lukas-reineke/indent-blankline.nvim"] = {opt = true, config = conf.blankline} -- after="nvim-treesitter",

ui["sainnhe/sonokai"] = {opt = true, config = conf.sonokai}
ui["sainnhe/gruvbox-material"] = {opt = true, config = conf.gruvbox}

-- cant config cursor line
-- ui["rafamadriz/neon"] = {opt = true, config = conf.neon}

return ui
