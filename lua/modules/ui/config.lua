local config = {}
packer_plugins = packer_plugins or {} -- supress warning

function config.windline()
  if not packer_plugins["nvim-web-devicons"].loaded then
    packer_plugins["nvim-web-devicons"].loaded = true
    require"packer".loader("nvim-web-devicons")
  end

  -- require('wlfloatline').toggle()
end

local winwidth = function()
  return vim.api.nvim_call_function("winwidth", {0})
end

function config.sonokai()
  local opt = {"andromeda", "default", "andromeda", "shusia", "maia", "atlantis", "espresso"}
  local v = opt[math.random(1, #opt)]
  vim.g.sonokai_style = v
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_diagnostic_virtual_text = 'colored'
  vim.g.sonokai_disable_italic_comment = 1
  vim.g.sonokai_current_word = 'underline'
  vim.cmd([[colorscheme sonokai]])
  vim.cmd([[hi CurrentWord guifg=#E3F467 guibg=#332248 gui=Bold,undercurl]])
  vim.cmd([[hi TSKeyword gui=Bold]])
end

function config.blankline()
  require("indent_blankline").setup {
    enabled = true,
    -- char = "|",
    char_list = {"", "┊", "┆", "¦", "|", "¦", "┆", "┊", ""},
    filetype_exclude = {"help", "startify", "dashboard", "packer", "guihua", "NvimTree", "sidekick"},
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    buftype_exclude = {"terminal"},
    space_char_blankline = " ",
    use_treesitter = true,
    show_current_context = true,
    context_patterns = {
      "class", "return", "function", "method", "^if", "if", "^while", "jsx_element", "^for", "for",
      "^object", "^table", "block", "arguments", "if_statement", "else_clause", "jsx_element",
      "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement",
      "operation_type"
    },
    bufname_exclude = {"README.md"}
  }
end

function config.gruvbox()
  local palette = "original"
  vim.cmd("set background=dark")
  vim.g.gruvbox_material_invert_selection = 0
  vim.g.gruvbox_material_enable_italic = 1
  vim.cmd([[if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif]])
  -- vim.g.gruvbox_material_invert_signs = 1
  vim.g.gruvbox_material_improved_strings = 1
  vim.g.gruvbox_material_improved_warnings = 1
  vim.g.gruvbox_material_enable_bold = 1
  vim.g.gruvbox_material_palette = palette
  vim.cmd("colorscheme gruvbox-material")
  vim.cmd("doautocmd ColorScheme")
end

return config
