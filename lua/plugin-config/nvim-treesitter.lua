require'nvim-treesitter.configs'.setup{
  -- A list of parser names, or "all"
  ensure_installed = {"c", "lua", "cpp", "cuda", "json", "cmake", "vim", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {  },
  
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {  },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = { 
        "#48d1cc",
        "#7b68ee",
        "#87cefa",
        "#cd5c5c",
        "#20b2aa",
        "#003153",
        "#3cb371",
        "#de3163",
        "#66cdaa",
        "#00bfff",
        "#007fff",
        "#ffcc00",
        "#dc143c",
        "#a6ffcc",
        "#e6b800",
        "#4b0080",
        
    }, 
    playground = {
        enable = true,
        updatetime = 25,
        disable = {},
        persist_queries = false,
    },
    --termcolors = { }, 
  }
}
