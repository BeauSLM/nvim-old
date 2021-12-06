local user = {}

user["junegunn/gv.vim"] = {
  opt = true,
  requires = {"tpope/vim-fugitive", opt = true,},
}

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
