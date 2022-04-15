local enable = true
local langtree = true
local lines = vim.fn.line('$')

local treesitter = function()
    lprint("loading treesitter")
    if lines > 30000 then -- skip some settings for large file
        -- vim.cmd[[syntax on]]
        print('skip treesitter')
        require"nvim-treesitter.configs".setup {highlight = {enable = enable}}
        return
    end

    if lines > 7000 then
        enable = false
        langtree = false
        print("disable ts txtobj")
    end

    require"nvim-treesitter.configs".setup {
        highlight = {
            enable = true, -- false will disable the whole extension
            additional_vim_regex_highlighting = false,
            disable = {"elm"}, -- list of language that will be disabled
            use_languagetree = langtree,
            custom_captures = {todo = 'Todo'}
        },
        incremental_selection = {
            enable = enable,
            -- disable = {"elm"},
            keymaps = {
                -- mappings for incremental selection (visual mappings)
                init_selection = "gnn", -- maps in normal mode to init the node/scope selection
                scope_incremental = "gnn", -- increment to the upper scope (as defined in locals.scm)
                node_incremental = "<TAB>", -- increment to the upper named parent
                node_decremental = "<S-TAB>" -- decrement to the previous node
            }
        }
    }
end

local treesitter_obj = function()
    lprint("loading treesitter textobj")
    if lines > 30000 then -- skip some settings for large file
        print('skip treesitter obj')
        return
    end

    require"nvim-treesitter.configs".setup {

        indent = {enable = true},
        context_commentstring = {enable = true, enable_autocmd = false},
        textobjects = {
            -- syntax-aware textobjects
            enable = enable,
            disable = {"elm"},
            lsp_interop = {
                enable = enable
                -- peek_definition_code = {["DF"] = "@function.outer", ["CF"] = "@class.outer"}
            },
            keymaps = {
                ["iL"] = {
                    -- you can define your own textobjects directly here
                    python = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function",
                    go = "(function_definition) @function",
                    java = "(method_declaration) @function"
                },
                -- or you use the queries from supported languages with textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aC"] = "@class.outer",
                ["iC"] = "@class.inner",
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["ae"] = "@block.outer",
                ["ie"] = "@block.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["is"] = "@statement.inner",
                ["as"] = "@statement.outer",
                ["ad"] = "@comment.outer",
                ["am"] = "@call.outer",
                ["im"] = "@call.inner"
            },
            move = {
                enable = enable,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"},
                goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
                goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"},
                goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}
            },
            select = {
                enable = enable,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    -- Or you can define your own textobjects like this
                    ["iF"] = {
                        python = "(function_definition) @function",
                        cpp = "(function_definition) @function",
                        c = "(function_definition) @function",
                        java = "(method_declaration) @function",
                        go = "(method_declaration) @function"
                    }
                }
            },
            swap = {
                enable = enable,
                -- swap_next = {["<leader>a"] = "@parameter.inner"},
                -- swap_previous = {["<leader>A"] = "@parameter.inner"}
            }
        },
        -- ensure_installed = "maintained"
        ensure_installed = {
            "go", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java", "toml",
            "tsx", "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue", "comment",
            "bash", "cmake", "fish", "llvm", "php", "make", "regex", "vim", "zig", "markdown", "c_sharp", "cuda", "http", "ninja",
        }
    }

    vim.cmd([[syntax on]])
end

-- treesitter()

return {
    treesitter = treesitter,
    treesitter_obj = treesitter_obj,
}
