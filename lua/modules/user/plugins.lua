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

user["abecodes/tabout.nvim"] = {
  opt = true,
  after = {"nvim-treesitter"},
  config = function ()
    require("tabout").setup {
      completion = false,
    }
  end,
}

user["fraserlee/ScratchPad"] = {disable = true,}
return user
