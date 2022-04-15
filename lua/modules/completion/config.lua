local global = require 'core.global'
local config = {}

function config.nvim_cmp()
  local cmp = require('cmp')

  if load_coq() then
    local sources = {}
    cmp.setup.buffer {completion = {autocomplete = false}}
    return
  end
  -- print("cmp setup")
  local comp_kind = nil
  local sources = {
    {name = 'luasnip'}, {name = 'nvim_lsp'}, {name = 'treesitter', keyword_length = 2},
    {name = 'look', keyword_length = 4}
    -- {name = 'buffer', keyword_length = 4} {name = 'path'}, {name = 'look'},
    -- {name = 'calc'}, {name = 'ultisnips'} { name = 'snippy' }
  }
  if vim.o.ft == 'norg' then
    table.insert(sources, {name = 'neorg'})
  end
  if vim.o.ft == 'markdown' then
    table.insert(sources, {name = 'spell'})
    table.insert(sources, {name = 'look'})
  end
  if vim.o.ft == 'lua' then
    table.insert(sources, {name = 'nvim_lua'})
  end
  if vim.o.ft == 'zsh' or vim.o.ft == 'sh' or vim.o.ft == 'fish' or vim.o.ft == 'proto' then
    table.insert(sources, {name = 'path'})
    table.insert(sources, {name = 'buffer', keyword_length = 3})
    table.insert(sources, {name = 'calc'})
  end
  if vim.o.ft == 'toml' then
    table.insert(sources, {name = 'crates'})
  end
  cmp.setup {
    snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
        -- require 'snippy'.expand_snippet(args.body)
        -- vim.fn["UltiSnips#Anon"](args.body)
      end
    },
    completion = {
      autocomplete = {require("cmp.types").cmp.TriggerEvent.TextChanged},
      completeopt = "menu,menuone,noselect"
    },
    formatting = {
      format = function(entry, vim_item)
        -- print(vim.inspect(vim_item.kind))
        if cmp_kind == nil then
          cmp_kind = require"navigator.lspclient.lspkind".cmp_kind
        end
        vim_item.kind = cmp_kind(vim_item.kind)
        vim_item.menu = ({
          buffer = " ﬘",
          nvim_lsp = " ",
          luasnip = " 🐍",
          treesitter = ' ',
          nvim_lua = " ",
          spell = ' 暈'
        })[entry.source.name]
        return vim_item
      end
    },
    -- documentation = {
    --   border = "rounded",
    -- },
    -- You must set mapping if you want.
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false}),
    },

    -- You should specify your *installed* sources.
    sources = sources,

    experimental = {ghost_text = true}
  }
  require"packer".loader("nvim-autopairs")
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

  -- require'cmp'.setup.cmdline(':', {sources = {{name = 'cmdline'}}})
  if vim.o.ft == 'clap_input' or vim.o.ft == 'guihua' or vim.o.ft == 'guihua_rust' then
    require'cmp'.setup.buffer {completion = {enable = false}}
  end
  vim.cmd("autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }")
  vim.cmd("autocmd FileType clap_input lua require('cmp').setup.buffer { enabled = false }")
  -- if vim.o.ft ~= 'sql' then
  --   require'cmp'.setup.buffer { completion = {autocomplete = false} }
  -- end
end

function config.luasnip()
  local ls = require "luasnip"
  ls.config.set_config {history = true, updateevents = "TextChanged,TextChangedI"}
  require("luasnip.loaders.from_vscode").load {}

  vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
  vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
  vim.cmd [[
    imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
    inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
    imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
    snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
    snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
  ]]
end

function config.telescope_preload()
  if not packer_plugins["plenary.nvim"].loaded then
    require"packer".loader("plenary.nvim")
  end
end

function config.telescope()
  require("utils.telescope").setup()
end

return config
