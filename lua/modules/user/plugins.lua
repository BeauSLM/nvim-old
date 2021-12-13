local user = {}

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

-- TODO: replace with lualine!
user["itchyny/lightline.vim"] = {
  event = "UIEnter",
  config = function ()
    vim.cmd([[
    let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

    ]])
  end,
  opt = true
}

-- your plugin config
return user
