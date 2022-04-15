local config = {}

local function load_env_file()
  local env_file = require'core.global'.home .. "/.env"
  local env_contents = {}
  if vim.fn.filereadable(env_file) ~= 1 then
    print(".env file does not exist")
    return
  end
  local contents = vim.fn.readfile(env_file)
  for _, item in pairs(contents) do
    local line_content = vim.fn.split(item, "=")
    env_contents[line_content[1]] = line_content[2]
  end
  return env_contents
end

local function load_dbs()
  local env_contents = load_env_file()
  local dbs = {}
  for key, value in pairs(env_contents) do
    if vim.fn.stridx(key, "DB_CONNECTION_") >= 0 then
      local db_name = vim.fn.split(key, "_")[3]:lower()
      dbs[db_name] = value
    end
  end
  return dbs
end

function config.vim_vista()
  vim.g["vista#renderer#enable_icon"] = 1
  vim.g.vista_disable_statusline = 1

  vim.g.vista_default_executive = "nvim_lsp" -- ctag
  vim.g.vista_echo_cursor_strategy = "floating_win"
  vim.g.vista_vimwiki_executive = "markdown"
  vim.g.vista_executive_for = {
    vimwiki = "markdown",
    pandoc = "markdown",
    markdown = "toc",
    typescript = "nvim_lsp",
    typescriptreact = "nvim_lsp",
    go = "nvim_lsp",
    lua = "nvim_lsp"
  }

  -- vim.g['vista#renderer#icons'] = {['function'] = "", ['method'] = "ℱ", variable = "כֿ"}
end

-- function config.far()
--   -- body
--   -- vim.cmd [[UpdateRemotePlugins]]
--   vim.g["far#source"] = "rgnvim"
--   vim.g["far#cmdparse_mode"] = "shell"
-- end

function config.clap()
  vim.g.clap_preview_size = 10
  vim.g.airline_powerline_fonts = 1
  vim.g.clap_layout = {width = "80%", row = "8%", col = "10%", height = "34%"} -- height = "40%", row = "17%", relative = "editor",
  -- vim.g.clap_popup_border = "rounded"
  vim.g.clap_selected_sign = {text = "", texthl = "ClapSelectedSign", linehl = "ClapSelected"}
  vim.g.clap_current_selection_sign = {
    text = "",
    texthl = "ClapCurrentSelectionSign",
    linehl = "ClapCurrentSelection"
  }
  -- vim.g.clap_always_open_preview = true
  vim.g.clap_preview_direction = "UD"
  -- if vim.g.colors_name == 'zephyr' then
  vim.g.clap_theme = 'material_design_dark'
  vim.api.nvim_command(
      "autocmd FileType clap_input lua require'cmp'.setup.buffer { completion = {autocomplete = false} }")
  -- end
  -- vim.api.nvim_command("autocmd FileType clap_input call compe#setup({ 'enabled': v:false }, 0)")
end

function config.clap_after()
  if not packer_plugins["nvim-cmp"].loaded then
    require"packer".loader("nvim-cmp")
  end
end

function config.bqf()
  require('bqf').setup({
    auto_enable = true,
    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'}
    },
    func_map = {vsplit = '', ptogglemode = 'z,', stoggleup = ''},
    filter = {
      fzf = {
        action_for = {['ctrl-s'] = 'split'},
        extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
      }
    }
  })
end

function config.markdown()
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_folding_level = 6
  vim.g.vim_markdown_override_foldtext = 1
  vim.g.vim_markdown_folding_style_pythonic = 1
  vim.g.vim_markdown_conceal = 1
  vim.g.vim_markdown_conceal_code_blocks = 1
  vim.g.vim_markdown_new_list_item_indent = 0
  vim.g.vim_markdown_toc_autofit = 0
  vim.g.vim_markdown_edit_url_in = "vsplit"
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_fenced_languages = {
    "c++=javascript", "js=javascript", "json=javascript", "jsx=javascript", "tsx=javascript"
  }
end

function config.spelunker()
  -- vim.cmd("command! Spell call spelunker#check()")
  vim.g.enable_spelunker_vim_on_readonly = 0
  vim.g.spelunker_check_type = 2
  vim.g.spelunker_highlight_type = 2
  vim.g.spelunker_disable_uri_checking = 1
  vim.g.spelunker_disable_account_name_checking = 1
  vim.g.spelunker_disable_email_checking = 1
  -- vim.cmd("highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=undercurl guifg=#F3206e guisp=#EF3050")
  -- vim.cmd("highlight SpelunkerComplexOrCompoundWord cterm=underline gui=undercurl guisp=#EF3050")
  vim.cmd("highlight def link SpelunkerSpellBad SpellBad")
  vim.cmd("highlight def link SpelunkerComplexOrCompoundWord Rare")
end

function config.spellcheck()

  vim.cmd("highlight def link SpelunkerSpellBad SpellBad")
  vim.cmd("highlight def link SpelunkerComplexOrCompoundWord Rare")

  vim.fn["spelunker#check"]()
end

function config.grammcheck()
  -- body
  if not packer_plugins["rhysd/vim-grammarous"] or not packer_plugins["rhysd/vim-grammarous"].loaded then
    require"packer".loader("vim-grammarous")
  end
  vim.cmd [[GrammarousCheck]]
end
function config.vim_test()
  vim.g["test#strategy"] = {nearest = "neovim", file = "neovim", suite = "neovim"}
  vim.g["test#neovim#term_position"] = "vert botright 60"
  vim.g["test#go#runner"] = "ginkgo"
  -- nmap <silent> t<C-n> :TestNearest<CR>
  -- nmap <silent> t<C-f> :TestFile<CR>
  -- nmap <silent> t<C-s> :TestSuite<CR>
  -- nmap <silent> t<C-l> :TestLast<CR>
  -- nmap <silent> t<C-g> :TestVisit<CR>
end

function config.mkdp()
  -- print("mkdp")
  vim.g.mkdp_command_for_global = 1
  vim.cmd(
      [[let g:mkdp_preview_options = { 'mkit': {}, 'katex': {}, 'uml': {}, 'maid': {}, 'disable_sync_scroll': 0, 'sync_scroll_type': 'middle', 'hide_yaml_meta': 1, 'sequence_diagrams': {}, 'flowchart_diagrams': {}, 'content_editable': v:true, 'disable_filename': 0 }]])
end

function config.snap()
  local snap = require 'snap'
  local limit = snap.get "consumer.limit"
  local select_vimgrep = snap.get "select.vimgrep"
  local preview_file = snap.get "preview.file"
  local preview_vimgrep = snap.get "preview.vimgrep"
  local producer_vimgrep = snap.get "producer.ripgrep.vimgrep"
  function _G.snap_grep()
    snap.run({
      prompt = "  Grep  ",
      producer = limit(10000, producer_vimgrep),
      select = select_vimgrep.select,
      steps = {{consumer = snap.get "consumer.fzf", config = {prompt = "FZF>"}}},
      multiselect = select_vimgrep.multiselect,
      views = {preview_vimgrep}
    })
  end

  function _G.snap_grep_selected_word()
    snap.run({
      prompt = "  Grep  ",
      producer = limit(10000, producer_vimgrep),
      select = select_vimgrep.select,
      multiselect = select_vimgrep.multiselect,
      views = {preview_vimgrep},
      initial_filter = vim.fn.expand("<cword>")
    })
  end

  snap.maps {
    {"<Leader>rg", snap.config.file {producer = "ripgrep.file"}},
    -- {"<Leader>fb", snap.config.file {producer = "vim.buffer"}},
    {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}},
    -- {"<Leader>ff", snap.config.vimgrep {}},
    {
      "<Leader>fz", function()
        snap.run {
          prompt = "  Grep  ",
          producer = limit(1000, snap.get'producer.ripgrep.vimgrep'.args({'--ignore-case'})),
          steps = {{consumer = snap.get 'consumer.fzf', config = {prompt = " Fzf  "}}},
          select = snap.get'select.file'.select,
          multiselect = snap.get'select.file'.multiselect,
          views = {snap.get 'preview.vimgrep'}
        }
      end
    }
  }
end

return config
