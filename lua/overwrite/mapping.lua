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
  ["n|<M-g>"] = map_cu("Clap gfiles"):with_noremap():with_silent(),

  ["n|<C-k>"] = map_cmd('v:lua.ctrl_k()'):with_silent():with_expr(),

  ["n|<Leader>v"] = map_cu("Vista!!"):with_noremap():with_silent(),
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
  ["n|<Leader>sp"] = map_cu("lua require'telescope.builtin'.lsp_workspace_symbols()"):with_noremap():with_silent(),
  ["n|<Leader>ss"] = map_cu("lua require'telescope.builtin'.treesitter()"):with_noremap():with_silent(),
  -- ["n|<Leader>ss"] = map_cu("lua require'telescope.builtin'.lsp_document_symbols()"):with_noremap():with_silent(),

  -- harpoon navigation
  ["n|<Leader>a"] = map_cr("lua require'harpoon.mark'.toggle_file()"),
  ["n|<Leader>ht"] = map_cr("lua require'harpoon.ui'.toggle_quick_menu()"),
  ["n|<Leader>y"] = map_cr("lua require'harpoon.cmd-ui'.toggle_quick_menu()"),

  ["n|<Leader>j"] = map_cr("lua require'harpoon.ui'.nav_file(1)"),
  ["n|<Leader>k"] = map_cr("lua require'harpoon.ui'.nav_file(2)"),
  ["n|<Leader>l"] = map_cr("lua require'harpoon.ui'.nav_file(3)"),
  ["n|<Leader>;"] = map_cr("lua require'harpoon.ui'.nav_file(4)"),

  ["n|<Leader>tj"] = map_cr("lua require'harpoon.term'.gotoTerminal(1)"),
  ["n|<Leader>tk"] = map_cr("lua require'harpoon.term'.gotoTerminal(2)"),
  ["n|<Leader>tl"] = map_cr("lua require'harpoon.term'.gotoTerminal(3)"),

  ["n|<Leader>cj"] = map_cr("lua require'harpoon.term'.sendCommand(1, 1)"),
  ["n|<Leader>ck"] = map_cr("lua require'harpoon.term'.sendCommand(1, 2)"),

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
  ["n|<Leader>nf"] = map_cr(":lua require'neogen'.generate( { type = 'func' } )"):with_noremap():with_silent(),
  ["n|<Leader>nt"] = map_cr(":lua require'neogen'.generate( { type = 'type' } )"):with_noremap():with_silent(),
  ["n|<Leader>nc"] = map_cr(":lua require'neogen'.generate( { type = 'class' } )"):with_noremap():with_silent(),
  ["n|<Leader>nl"] = map_cr(":lua require'neogen'.generate( { type = 'file' } )"):with_noremap():with_silent(),
}

-- good telescope project search
vim.cmd([[
  nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
]])
--
vim.cmd([[vnoremap J :m '>+1<CR>gv=gv]])
vim.cmd([[vnoremap K :m '<-2<CR>gv=gv]])
--
bind.nvim_load_mapping(keys)

vim.cmd([[command! -nargs=*  HpoonClear lua require"harpoon.mark".clear_all()]])
-- Use `git ls-files` for git files, use `find ./ *` for all files under work directory.
--
return K
