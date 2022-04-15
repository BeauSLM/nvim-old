local config = {}
-- local bind = require('keymap.bind')
-- local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
-- local loader = require"packer".loader

function config.nvim_treesitter()
  require("modules.lang.treesitter").treesitter()
end

function config.refactor()
  local refactor = require("refactoring")
  refactor.setup({})

  lprint("refactor")
  _G.ts_refactors = function()
    -- telescope refactoring helper
    local function _refactor(prompt_bufnr)
      local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
      require("telescope.actions").close(prompt_bufnr)
      require("refactoring").refactor(content.value)
    end

    local opts = require("telescope.themes").get_cursor() -- set personal telescope options
    require("telescope.pickers").new(opts, {
      prompt_title = "refactors",
      finder = require("telescope.finders").new_table({
        results = require("refactoring").get_refactors(),
      }),
      sorter = require("telescope.config").values.generic_sorter(opts),
      attach_mappings = function(_, map)
        map("i", "<CR>", _refactor)
        map("n", "<CR>", _refactor)
        return true
      end,
    }):find()
  end
end

function config.sqls() end

-- https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

local path = vim.split(package.path, ";")

table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

function config.navigator()
  local luadev = {}
  -- if ok and l then
  --   luadev = l.setup(cfg)
  -- end

  local sumneko_root_path = vim.fn.expand("$HOME") .. "/Code/Source_Installs/lua-language-server"
  local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
  luadev.sumneko_root_path = sumneko_root_path
  luadev.sumneko_binary = sumneko_binary

  -- local capabilities = vim.lsp.protocol.make_client_capabilities()

  local single = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

  local efm_cfg = require('modules.lang.efm').efm

  -- loader('aerial.nvim')
  local nav_cfg = {
    debug = plugin_debug(),
    width = 0.7,
    lsp_installer = false,
    on_attach = function(client, bufnr)
      -- require'aerial'.on_attach(client, bufnr)
    end,
    border = single, -- "single",
    ts_fold = true,
    -- external = true, -- true: enable for goneovim multigrid otherwise false
    lsp_signature_help = true,
    -- default_mapping = false,
    keymaps = {
      { 
        key = "<Leader>Gr",
        func = "require('navigator.reference').async_ref()"
      },
      {
        key = "<Leader>LA",
        func = "require('navigator.codelens').run_action()",
      },
      {
        key = "<Leader>K",
        func = "require('navigator.dochighlight').hi_symbol()",
      }
    },
    lsp = {
      format_on_save = false, -- set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
      disable_format_cap = { "sqls", "gopls" }, -- a list of lsp not enable auto-format (e.g. if you using efm or vim-codeformat etc)
      -- disable_lsp = {'denols'},
      disable_lsp = { "rls", "flow", "pylsp" },
      code_lens = true,
      disply_diagnostic_qf = false,
      denols = { filetypes = {} },
      tsserver = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = false -- allow efm to format
        end,
      },
      flow = { autostart = false },
      gopls = {
        -- on_attach = function(client)
        --   -- print("i am a hook")
        --   -- client.resolved_capabilities.document_formatting = false -- efm
        -- end,
        settings = {
          gopls = { gofumpt = true }, -- enable gofumpt etc,
        },
        -- set to {} to disable the lspclient for all filetype
      },
      sqls = {
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = false -- efm
        end,
      },
      ccls = { filetypes = {} }, -- using clangd

      sumneko_lua = luadev,

      jedi_language_server = { filetypes = {} },
    },

    -- icons = {
    --   diagnostic_err = "",
    --   diagnostic_warn = "",
    --   diagnostic_info = [[]],
    --   diagnostic_hint = [[ﯦ]],
    --   diagnostic_virtual_text = ""
    -- }
  }

  if not use_nulls() then
    nav_cfg.lsp.efm = require("modules.lang.efm").efm
  else
    table.insert(nav_cfg.lsp.disable_lsp, "efm")
  end

  vim.lsp.set_log_level("error") -- error debug info
  -- require"navigator".setup(nav_cfg)
  -- PLoader('aerial.nvim')
  require("navigator").setup(nav_cfg)
end

function config.go()
  require("go").setup({
    verbose = plugin_debug(),
    -- goimport = 'goimports', -- 'gopls'
    filstruct = "gopls",
    log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
    lsp_codelens = false, -- use navigator
    dap_debug = true,

    dap_debug_gui = true,
    test_runner = "richgo", -- richgo, go test, richgo, dlv, ginkgo
    -- run_in_floaterm = true, -- set to true to run in float window.
  })

  vim.cmd("augroup go")
  vim.cmd("autocmd!")
  vim.cmd("autocmd FileType go nmap <leader>gb  :GoBuild")
  --  Show by default 4 spaces for a tab')
  vim.cmd("autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4")
  --  :GoBuild and :GoTestCompile')
  -- vim.cmd('autocmd FileType go nmap <leader><leader>gb :<C-u>call <SID>build_go_files()<CR>')
  --  :GoTest')
  vim.cmd("autocmd FileType go nmap <leader>gt  GoTest")
  --  :GoRun

  vim.cmd("autocmd FileType go nmap <Leader><Leader>l GoLint")
  vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()")

  vim.cmd("au FileType go command! Gtn :TestNearest -v -tags=integration")
  vim.cmd("au FileType go command! Gts :TestSuite -v -tags=integration")
  vim.cmd("augroup END")
end

function config.dap()
  -- dap.adapters.node2 = {
  --   type = 'executable',
  --   command = 'node',
  --   args = {os.getenv('HOME') .. '/apps/vscode-node-debug2/out/src/nodeDebug.js'},
  -- }
  -- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
  -- vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
  -- require('telescope').load_extension('dap')
  -- vim.g.dap_virtual_text = true
end

return config
