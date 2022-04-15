local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
  -- Vim map
  ["n|Y"] = map_cmd('y$'),
  ["i|<C-h>"] = map_cmd('<BS>'):with_noremap(),
}

local os_map = {
  ["n|<c-s>"] = map_cu('write'):with_noremap(),
  ["i|<c-s>"] = map_cu('"normal :w"'):with_noremap():with_silent(),
  ["v|<c-s>"] = map_cu('"normal :w"'):with_noremap():with_silent(),
}

def_map = vim.tbl_extend("keep", def_map, os_map)

bind.nvim_load_mapping(def_map)
