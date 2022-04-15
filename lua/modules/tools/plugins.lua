local tools = {}
local conf = require("modules.tools.config")

tools['ThePrimeagen/harpoon'] = {
  opt = true,
  config = function()
    require("harpoon").setup({
      global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = {"harpoon"}
      }
    })
    require("telescope").load_extension('harpoon')
  end
}

tools["liuchengxu/vista.vim"] = {cmd = "Vista", setup = conf.vim_vista, opt = true}

tools["kamykn/spelunker.vim"] = {
  opt = true,
  fn = {"spelunker#check"},
  setup = conf.spelunker,
  config = conf.spellcheck
}
tools["rhysd/vim-grammarous"] = {
  opt = true,
  cmd = {"GrammarousCheck"},
  ft = {"markdown", "txt"},
  setup = conf.grammarous
}

tools["plasticboy/vim-markdown"] = {
  ft = "markdown",
  requires = {"godlygeek/tabular"},
  cmd = {"Toc"},
  setup = conf.markdown,
  opt = true
}

tools["liuchengxu/vim-clap"] = {
  cmd = "Clap",
  requires = { "junegunn/fzf", opt = true, },
  run = function()
    vim.fn["clap#installer#build_maple"]()
    vim.fn["clap#installer#build_python_dynamic_module"]()
  end,
  setup = conf.clap,
  config = conf.clap_after
}

local path = plugin_folder()
tools[path .. "sad.nvim"] = {
  cmd = {'Sad'},
  opt = true,
  config = function()
    require'sad'.setup({debug = true, log_path = "~/tmp/neovim_debug.log"})
  end
}

tools[path .. "viewdoc.nvim"] = {
  cmd = {'Viewdoc'},
  opt = true,
  config = function()
    require'viewdoc'.setup({debug = true, log_path = "~/tmp/neovim_debug.log"})
  end
}

tools['kevinhwang91/nvim-bqf'] = {
  opt = true,
  event = {"CmdlineEnter", "QuickfixCmdPre"},
  config = conf.bqf
}

return tools
