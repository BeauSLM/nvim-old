local vim = vim

local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

-- "*.v, *.go, *.json, *.js, *.jsx, *.php, *.c, *.h, *.cpp, *.cxx, *.java, *.tml, *.tsx, *.lua, *.ts, *.py, *.sh, *.zsh, *.css, *.html. *.dart"
function autocmd.load_autocmds()
  local definitions = {
    bufs = {
      {
        "FileType", "markdown",
        "let b:prettier_exec_cmd = 'prettier' | let g:prettier#exec_cmd_path = '/usr/local/bin/prettier' | let g:spelunker_check_type = 1"
      },
      {"BufWritePost", "plugins.lua", "PackerCompile"},
      {"BufReadPre", "*", ":silent! :lua require('modules.lang.config').nvim_treesitter()"}
    }
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
return autocmd
