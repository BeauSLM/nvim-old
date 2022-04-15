local editor = {}

local conf = require("modules.editor.config")

-- alternatives: steelsojka/pears.nvim
-- windwp/nvim-ts-autotag  'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue'
-- windwp/nvim-autopairs

editor["windwp/nvim-autopairs"] = {
  -- keys = {{'i', '('}},
  -- keys = {{'i'}},
  after = {"nvim-cmp"}, -- "nvim-treesitter", nvim-cmp "nvim-treesitter", coq_nvim
  -- event = "InsertEnter",  --InsertCharPre
  -- after = "hrsh7th/nvim-compe",
  config = conf.autopairs,
  opt = true
}
editor["tpope/vim-surround"] = {
  opt = true
  -- event = 'InsertEnter',
  -- keys={'c', 'd'}
}

-- nvim-colorizer replacement
editor["rrethy/vim-hexokinase"] = {
  -- ft = { 'html','css','sass','vim','typescript','typescriptreact'},
  config = conf.hexokinase,
  run = "make hexokinase",
  opt = true,
  cmd = {"HexokinaseTurnOn", "HexokinaseToggle"}
}

editor["numToStr/Comment.nvim"] = {
  keys = {'g', '<ESC>'},
  event = {'CursorMoved'},
  config = conf.comment
}

editor["AndrewRadev/splitjoin.vim"] = {
  opt = true,
  cmd = {"SplitjoinJoin", "SplitjoinSplit"},
}

editor["chaoren/vim-wordmotion"] = {
  opt = true,
  fn = {"<Plug>WordMotion_w"}
  -- keys = {'w','W', 'gE', 'aW'}
}

return editor
