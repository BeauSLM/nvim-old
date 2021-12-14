local user = {}
local conf = require("modules.user.config")

-- possibly remove this later
user["tpope/vim-eunuch"] = {}

user["junegunn/gv.vim"] = {
  opt = true,
  requires = {"tpope/vim-fugitive", opt = true,},
}

user["tpope/vim-rhubarb"] = {
  opt = true,
  after = "vim-fugitive"
}

user["shumphrey/fugitive-gitlab.vim"] = {
  opt = true,
  after = "vim-fugitive"
}

-- TODO: settings!
user["abecodes/tabout.nvim"] = {
  opt = true,
  after = {"nvim-treesitter"},
  config = function ()
    require("tabout").setup {
      completion = false,
    }
  end,
}

user["nvim-lualine/lualine.nvim"] = {
  disable = true,
  opt = true,
  after = "nvim-web-devicons",
  event = "UIEnter",
  config = conf.lualine,
}

return user
