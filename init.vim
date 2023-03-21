set nocompatible
set showmatch
set hlsearch
set autoindent
set number
set wildmode=longest,list
set cc=120
filetype plugin indent on
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set noswapfile
syntax on

let g:do_filetype_lua=1

call plug#begin()

Plug 'vim/colorschemes'
Plug 'rose-pine/neovim'
Plug 'sainnhe/everforest'
Plug 'pgdouyon/vim-yin-yang'
Plug 'ron89/thesaurus_query.vim'
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'Qiskit/openqasm', {'rtp': 'plugins/vim/'}

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'tpope/vim-abolish'
Plug 'preservim/vim-pencil'
Plug 'Pocco81/HighStr.nvim'
Plug 'rhysd/vim-grammarous'
Plug 'vigoux/LanguageTool.nvim'

call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
  ensure_installed = { "c", "python", "cpp", "latex", "make", "cmake", "markdown", "json", "lua", "verilog"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

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

  refactor = {
    highlight_definitions = {
        enable = true,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = true,
    },
    highlight_current_scope = {
        enable = true,
    },
    smart_rename = {
        enable = true,
        keymaps = {
            smart_rename="grr",
        }
    },
    navigation = {
        enable = true,
        keymaps = {
            goto_definition = "gnd",
            list_definitions = "gnD",
            list_definitions_toc = "gO",
            goto_next_usage = "<a-*>",
            goto_previous_usage = "<a-#>",
       },
    },
  },
}
EOF

lua << EOF
require("nvim-tree").setup({
--    open_on_setup=true,
--    open_on_setup_file=true,
    hijack_cursor=true,
    sort_by = "extension",
    view = {
        adaptive_size = true,
    },
    filesystem_watchers = {
        enable = true,
    },
    renderer = {
        group_empty = true,
        icons = {
            show = {
                file=false,
                folder=false,
                folder_arrow=false,
                git=true,
            },  
        },
        highlight_opened_files="name",
    },
    filters = {
        dotfiles=true,
    },

})
EOF

lua << EOF
require("nvim-tree.api").tree.open()
EOF

let g:nvcode_termcolors=256

syntax on
colorscheme nvcode
