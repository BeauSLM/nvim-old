local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args

local loader = require"packer".loader
K = {}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local keys = {
  -- ["n|F13"]  = map_cmd("<S-F1>"),
  -- ["n|F14"]  = map_cmd("<S-F2>"),
  -- ["n|F15"]  = map_cmd("<S-F3>"),
  -- ["n|F16"]  = map_cmd("<S-F4>"),
  -- ["n|F17"]  = map_cmd("<S-F5>"),
  -- ["n|F18"]  = map_cmd("<S-F6>"),
  -- ["n|F19"]  = map_cmd("<S-F7>"),
  -- ["n|F20"]  = map_cmd("<S-F8>"),
  -- ["n|F21"]  = map_cmd("<S-F9>"),
  -- ["n|F22"]  = map_cmd("<S-F10>"),
  -- ["n|F23"]  = map_cmd("<S-F11>"),
  -- ["n|F24"]  = map_cmd("<S-F12>"),
  --
  --
  -- pack?
  -- ["n|<Leader>tr"]     = map_cr("call dein#recache_runtimepath()"):with_noremap():with_silent(),
  -- ["n|<Leader>tf"]     = map_cu('DashboardNewFile'):with_noremap():with_silent(),
  --
  -- Lsp mapp work when insertenter and lsp start
  --
  -- ["n|<Leader>tc"] = map_cu("Clap colors"):with_noremap():with_silent(),
  -- ["n|<Leader>bb"] = map_cu("Clap buffers"):with_noremap():with_silent(),
  -- ["n|<Leader>ff"] = map_cu("Clap grep"):with_noremap():with_silent(),
  ["n|<Leader>fb"] = map_cu("Clap marks"):with_noremap():with_silent(),
  -- ["n|<C-x><C-f>"] = map_cu("Clap filer"):with_noremap():with_silent(),
  ["n|<Leader>ff"] = map_cu("Clap files ++finder=rg --ignore --hidden --files"):with_noremap():with_silent(),
  ["n|<M-g>"] = map_cu("Clap gfiles"):with_noremap():with_silent(),
  ["n|<Leader>fw"] = map_cu("Clap grep2 ++query=<cword>"):with_noremap():with_silent(),
  ["n|<C-h>"] = map_cu("Clap history"):with_noremap():with_silent(),

  -- ["n|<Leader>fW"] = map_cu("Clap windows"):with_noremap():with_silent(),
  -- ["n|<Leader>fl"] = map_cu("Clap loclist"):with_noremap():with_silent(),
  ["n|<Leader>fu"] = map_cu("Clap git_diff_files"):with_noremap():with_silent(),
  ["n|<Leader>fv"] = map_cu("Clap grep2 ++query=@visual"):with_noremap():with_silent(),
  ["n|<Leader>fh"] = map_cu("Clap command_history"):with_noremap():with_silent(),
  ["n|<Leader><Leader>r"] = map_cmd("v:lua.run_or_test()"):with_expr(),
  ["v|<Leader><Leader>r"] = map_cmd("v:lua.run_or_test()"):with_expr(),

  ["n|<Leader>di"] = map_cr("<cmd>lua require'dap.ui.variables'.hover()"):with_expr(),
  ["n|<Leader>dw"] = map_cr("<cmd>lua require'dap.ui.widgets'.hover()"):with_expr(), -- TODO: another key?
  ["v|<Leader>di"] = map_cr("<cmd>lua require'dap.ui.variables'.visual_hover()"):with_expr(),
  ["n|<C-k>"] = map_cmd('v:lua.ctrl_k()'):with_silent():with_expr(),

  -- Plugin QuickRun
  -- ["n|<Leader>r"]     = map_cr("<cmd> lua require'selfunc'.run_command()"):with_noremap():with_silent(),
  -- Plugin Vista
  ["n|<Leader>v"] = map_cu("Vista!!"):with_noremap():with_silent(),
  -- Plugin SplitJoin
  ["n|<Leader><Leader>s"] = map_cr("SplitjoinSplit"),
  ["n|<Leader><Leader>j"] = map_cr("SplitjoinJoin"),
  ["n|<F13>"] = map_cr("NvimTreeToggle"),

  -- clap --
  -- TODO: MORE OF THIS HOLY FUCK
  ["n|<d-C>"] = map_cu("Clap | startinsert"),
  ["i|<d-C>"] = map_cu("Clap | startinsert"):with_noremap():with_silent(),
  -- ["n|<d-p>"] = map_cu("Clap files | startinsert"),
  -- ["i|<d-p>"] = map_cu("Clap files | startinsert"):with_noremap():with_silent(),
  -- ["n|<d-m>"] = map_cu("Clap files | startinsert"),
  -- ["n|<M-m>"] = map_cu("Clap maps +mode=n | startinsert"),
  -- ["i|<M-m>"] = map_cu("Clap maps +mode=i | startinsert"),
  -- ["v|<M-m>"] = map_cu("Clap maps +mode=v | startinsert"),

  -- ["n|<d-f>"] = map_cu("Clap grep ++query=<cword> |  startinsert"),
  -- ["i|<d-f>"] = map_cu("Clap grep ++query=<cword> |  startinsert"):with_noremap():with_silent(),
  ["n|<Leader>df"] = map_cu("Clap dumb_jump ++query=<cword> | startinsert"),
  -- ["i|<Leader>df"] = map_cu("Clap dumb_jump ++query=<cword> | startinsert"):with_noremap():with_silent(),
  -- ["n|<F2>"] = map_cr(""):with_expr(),
  ["n|<F5>"] = map_cmd("v:lua.run_or_test(v:true)"):with_expr(),
  ["n|<F9>"] = map_cr("GoBreakToggle"),
  -- session
  -- ["n|<Leader>ss"] = map_cu('SessionSave'):with_noremap(),
  -- ["n|<Leader>sl"] = map_cu('SessionLoad'):with_noremap(),

  -- MEMEME

  -- navigation
  ["n|<C-q>"] = map_cr("q!"),
  ["n|<Leader>bd"] = map_cr("bd"),
  ["n|Q"] = map_cr("w<CR>:bd"),
  ["t|<C-o>"] = map_cmd("<C-\\><C-n><C-o>"),
  ["t|<C-q>"] = map_cr("<C-\\><C-n>:bd!"),

  ["t|<M-h>"] = map_cmd("<C-\\><C-n><C-w>h"),
  ["t|<M-j>"] = map_cmd("<C-\\><C-n><C-w>j"),
  ["t|<M-k>"] = map_cmd("<C-\\><C-n><C-w>k"),
  ["t|<M-l>"] = map_cmd("<C-\\><C-n><C-w>l"),
  -- ["i|<M-h>"] = map_cmd("<C-\\><C-n><C-w>h"),
  -- ["i|<M-j>"] = map_cmd("<C-\\><C-n><C-w>j"),
  -- ["i|<M-k>"] = map_cmd("<C-\\><C-n><C-w>k"),
  -- ["i|<M-l>"] = map_cmd("<C-\\><C-n><C-w>l"),
  ["n|<M-h>"] = map_cmd("<C-w>h"),
  ["n|<M-j>"] = map_cmd("<C-w>j"),
  ["n|<M-k>"] = map_cmd("<C-w>k"),
  ["n|<M-l>"] = map_cmd("<C-w>l"),
  ["n|<Leader>m"] = map_cr("MaximizerToggle"),

  -- symbols navigation
  ["n|<Leader>so"] = map_cr("SymbolsOutline"),
  ["n|<Leader>sp"] = map_cu("Clap proj_tags"):with_noremap():with_silent(),
  ["n|<Leader>ss"] = map_cu("Vista finder clap"):with_noremap():with_silent(), -- :Clap tags

  -- fugitive maps
  ["n|<Leader>gs"] = map_cr("Git"),
  ["n|<Leader>gd"] = map_cr("Git diff"),
  ["n|<Leader>gb"] = map_cr("Git blame"),
  ["n|<Leader>gj"] = map_cr("diffget //3"),
  ["n|<Leader>gf"] = map_cr("diffget //2"),
  ["n|<Leader>gl"] = map_cr("GV"),
  ["v|<Leader>gl"] = map_cr("GV"),
  ["n|<Leader>gv"] = map_cr("GV!"),
  ["v|<Leader>gv"] = map_cr("GV!"),
  ["n|<Leader>gp"] = map_cr("GV! --patch"),
  ["v|<Leader>gp"] = map_cr("GV! --patch"),
  ["v|<Leader>gL"] = map_cr("G log --patch"),

  ["n|<Leader>gga"] = map_cr("Git fetch --all"),
  ["n|<Leader>grum"] = map_cr("Git rebase upstream/master"),
  ["n|<Leader>grom"] = map_cr("Git rebase origin/master"),

  -- lsp maps
  ["n|<Leader>F"] = map_cr("lua vim.lsp.buf.formatting()"),

  -- neogen maps
  -- TODO: jump_next map! make same key as luasnip jump next
  ["n|<Leader>nf"] = map_cr(":lua require'neogen'.generate()"):with_noremap():with_silent(),
  ["n|<Leader>nt"] = map_cr(":lua require'neogen'.generate( { type = 'type' } )"):with_noremap():with_silent(),
  ["n|<Leader>nc"] = map_cr(":lua require'neogen'.generate( { type = 'class' } )"):with_noremap():with_silent(),
}

-- good telescope project search
vim.cmd([[
  nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
]])
--
vim.cmd([[vnoremap  <leader>y  "+y]])
vim.cmd([[nnoremap  <leader>Y  "+yg_]])
-- vim.cmd([[vnoremap  <M-c>  "+y]])
-- vim.cmd([[nnoremap  <M-c>  "+yg_]])

vim.cmd([[vnoremap J :m '>+1<CR>gv=gv]])
vim.cmd([[vnoremap K :m '<-2<CR>gv=gv]])

vim.cmd([[vnoremap  <D-c>  *+y]])
vim.cmd([[nnoremap  <D-c>  *+yg_]])
vim.cmd([[inoremap  <D-c>  *+yg_]])
vim.cmd([[inoremap  <D-v>  <CTRL-r>*]])

--
bind.nvim_load_mapping(keys)

_G.run_or_test = function(debug)
  local ft = vim.bo.filetype
  local fn = vim.fn.expand("%")
  fn = string.lower(fn)
  if fn == "[nvim-lua]" then
    if not packer_plugins["nvim-luadev"].loaded then
      loader("nvim-luadev")
    end
    return t("<Plug>(Luadev-Run)")
  end
  if ft == "lua" then
    local f = string.find(fn, "spec")
    if f == nil then
      -- let run lua test
      return t("<cmd>luafile %<CR>")
    end
    return t("<Plug>PlenaryTestFile")
  end
  if ft == "go" then
    local f = string.find(fn, "test.go")
    if f == nil then
      -- let run lua test
      if debug then
        return t("<cmd>GoDebug <CR>")
      else
        return t("<cmd>GoRun <CR>")
      end
    end

    if debug then
      return t("<cmd>GoDebug nearest<CR>")
    else
      return t("<cmd>GoTestFile <CR>")
    end
  end
end

vim.cmd([[command! -nargs=*  DebugOpen lua require"modules.lang.dap".prepare()]])
vim.cmd([[command! -nargs=*  HpoonClear lua require"harpoon.mark".clear_all()]])
-- Use `git ls-files` for git files, use `find ./ *` for all files under work directory.
--
return K
