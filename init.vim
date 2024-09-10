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

au! BufNewFile,BufRead *.tpp set filetype=cpp

let g:do_filetype_lua=1

call plug#begin()

" Writing plugins
" Plug 'lukas-reineke/headlines.nvim'
Plug 'ellisonleao/glow.nvim'

" Theme plugins
Plug 'rose-pine/neovim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }  " IN USE

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'kyazdani42/nvim-tree.lua'

" Other
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

Plug 'Pocco81/true-zen.nvim'

" Syntax plugins for tree-sitter.
Plug 'Qiskit/openqasm', {'rtp': 'plugins/vim/'}

call plug#end()

lua << EOF
require('glow').setup({
    width_ratio = 0.9,
    height_ratio = 0.9,
    border = 'rounded'
})

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
  ensure_installed = { "c", "python", "cpp", "latex", "make", "cmake", "markdown", "json", "lua", "verilog"},

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
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is -- the name of the parser)
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
        dotfiles=true, },

})
EOF

lua << EOF
require("nvim-tree.api").tree.open()
EOF

lua << EOF
require('rose-pine').setup({
    --- @usage 'auto'|'main'|'moon'|'dawn'
    variant = 'dawn',
    --- @usage 'main'|'moon'|'dawn'
    dark_variant = 'main',
    bold_vert_split = true,
    dim_nc_background = false,
    disable_background = true,
    disable_float_background = false,
    disable_italics = false,

    --- @usage string hex value or named color from rosepinetheme.com/palette
    groups = {
        background = 'base',
        background_nc = '_experimental_nc',
        panel = 'surface',
        panel_nc = 'base',
        border = 'highlight_med',
        comment = '#8f1a54',
---     comment = '#b5f5f2',
        link = 'iris',
        punctuation = 'subtle',

        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',

        headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
        }
        -- or set all headings at once
        -- headings = 'subtle'
    },

    -- Change specific vim highlight groups
    -- https://github.com/rose-pine/neovim/wiki/Recipes
    highlight_groups = {
        ColorColumn = { bg = 'rose' },

        -- Blend colours against the "base" background
---     CursorLine = { bg = '#eeffff', blend = 10 },
---     CursorLine = { bg = '#273170' },
        CursorLine = { bg = '#ffd2e8', blend = 100 },
        StatusLine = { fg = '#000000', bg = 'love', blend = 70 },
    }
})

require("catppuccin").setup({
    color_overrides = {
        latte = {
            base = "#f5f5dc",
            mantle = "#ffdac4"
        },
        frappe = {
            text = "#f5f5dc"
        }
    },
    integrations = {
        barbar = true
    }
})
EOF

nnoremap <silent>   <C-h> <Cmd>BufferPrevious<CR>
nnoremap <silent>   <C-l> <Cmd>BufferNext<CR>
nnoremap <silent>   <C-x> <Cmd>BufferClose<CR>
nnoremap <silent>   <C-j> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>   <C-k> <Cmd>BufferMoveNext<CR>

augroup TextLike
    autocmd!
    autocmd FileType markdown set textwidth=80 gggqG
augroup END

set background=light
colorscheme catppuccin-frappe
