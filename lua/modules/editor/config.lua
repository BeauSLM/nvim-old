local config = {}

function config.autopairs()
  local has_autopairs, autopairs = pcall(require, "nvim-autopairs")
  if not has_autopairs then
    print("autopairs not loaded")

    local loader = require"packer".loader
    loader('nvim-autopairs')
    has_autopairs, autopairs = pcall(require, "nvim-autopairs")
    if not has_autopairs then
      print("autopairs not installed")
      return
    end
  end
  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  npairs.setup({
    disable_filetype = {"TelescopePrompt", "guihua", "guihua_rust", "clap_input"},
    autopairs = {enable = true},
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""), -- "[%w%.+-"']",
    enable_check_bracket_line = false,
    html_break_line_filetype = {'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact'},
    check_ts = true,
    ts_config = {
      lua = {'string'}, -- it will not add pair on that treesitter node
      -- go = {'string'},
      javascript = {'template_string'},
      java = false -- don't check treesitter on java
    },
    fast_wrap = {
      map = '<M-e>',
      chars = {'{', '[', '(', '"', "'", "`"},
      pattern = string.gsub([[ [%'%"%`%+%)%>%]%)%}%,%s] ]], '%s+', ''),
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      hightlight = 'Search'
    }
  })
  local ts_conds = require('nvim-autopairs.ts-conds')
  -- you need setup cmp first put this after cmp.setup()

  npairs.add_rules {
    Rule(" ", " "):with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({"()", "[]", "{}"}, pair)
    end), Rule("(", ")"):with_pair(function(opts)
      return opts.prev_char:match ".%)" ~= nil
    end):use_key ")", Rule("{", "}"):with_pair(function(opts)
      return opts.prev_char:match ".%}" ~= nil
    end):use_key "}", Rule("[", "]"):with_pair(function(opts)
      return opts.prev_char:match ".%]" ~= nil
    end):use_key "]", Rule("%", "%", "lua") -- press % => %% is only inside comment or string
    :with_pair(ts_conds.is_ts_node({'string', 'comment'})),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({'function'}))
  }

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

  if load_coq() then
    local remap = vim.api.nvim_set_keymap
    local npairs = require('nvim-autopairs')

    npairs.setup({map_bs = false})

    vim.g.coq_settings = {keymap = {recommended = false}}

    -- these mappings are coq recommended mappings unrelated to nvim-autopairs
    remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], {expr = true, noremap = true})
    remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], {expr = true, noremap = true})
    remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], {expr = true, noremap = true})
    remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], {expr = true, noremap = true})

    -- skip it, if you use another global object
    _G.MUtils = {}

    MUtils.CR = function()
      if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({'selected'}).selected ~= -1 then
          return npairs.esc('<c-y>')
        else
          -- you can change <c-g><c-g> to <c-e> if you don't use other i_CTRL-X modes
          return npairs.esc('<c-g><c-g>') .. npairs.autopairs_cr()
        end
      else
        return npairs.autopairs_cr()
      end
    end
    remap('i', '<cr>', 'v:lua.MUtils.CR()', {expr = true, noremap = true})

    MUtils.BS = function()
      if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({'mode'}).mode == 'eval' then
        return npairs.esc('<c-e>') .. npairs.autopairs_bs()
      else
        return npairs.autopairs_bs()
      end
    end
    remap('i', '<bs>', 'v:lua.MUtils.BS()', {expr = true, noremap = true})
  end

  -- print("autopairs setup")
  -- skip it, if you use another global object

end

function config.hexokinase()
  vim.g.Hexokinase_optInPatterns = {
    "full_hex", "triple_hex", "rgb", "rgba", "hsl", "hsla", "colour_names"
  }
  vim.g.Hexokinase_highlighters = {
    "virtual", "sign_column", -- 'background',
    "backgroundfull"
    -- 'foreground',
    -- 'foregroundfull'
  }
end

function config.comment()
  require('Comment').setup({
    extended = true,
    pre_hook = function(ctx)
      -- print("ctx", vim.inspect(ctx))
      -- Only update commentstring for tsx filetypes
      if vim.bo.filetype == 'typescriptreact' or vim.bo.filetype == 'javascript' or vim.bo.filetype == 'css'
          or vim.bo.filetype == 'html' then
        require('ts_context_commentstring.internal').update_commentstring()
      end
    end,
    post_hook = function(ctx)
      -- lprint(ctx)
      if ctx.range.scol == -1 then
        -- do something with the current line
      else
        -- print(vim.inspect(ctx), ctx.range.srow, ctx.range.erow, ctx.range.scol, ctx.range.ecol)
        if ctx.range.ecol > 400 then
          ctx.range.ecol = 1
        end
        if ctx.cmotion > 1 then
          -- 322 324 0 2147483647
          vim.fn.setpos("'<", {0, ctx.range.srow, ctx.range.scol})
          vim.fn.setpos("'>", {0, ctx.range.erow, ctx.range.ecol})
          vim.cmd([[exe "norm! gv"]])
        end
      end
    end
  })
end

return config
