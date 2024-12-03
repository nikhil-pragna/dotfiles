vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "xiyaowong/transparent.nvim"
    use { 'christoomey/vim-tmux-navigator', }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use { "OlegGulevskyy/better-ts-errors.nvim",
        requires = {
            { "MunifTanjim/nui.nvim" }
        },
        config = function()
            require("better-ts-errors").setup({
                config = {
                    keymaps = {
                        toggle = '<leader>dd',          -- default '<leader>dd'
                        go_to_definition = '<leader>dx' -- default '<leader>dx'
                    }
                }
            })
        end
    }

    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons' } }
    })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use({
        'rose-pine/neovim',
        as = 'rose-pine'
    })

    use({
        'hrsh7th/nvim-cmp',
        requires = {
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
            },
            'saadparwaiz1/cmp_luasnip',

            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            'rafamadriz/friendly-snippets',
        }
    })

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use('ThePrimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('dstein64/vim-startuptime')
    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required

            -- Auto pair
            -- { 'jiangmiao/auto-pairs' },

            {
                'numToStr/Comment.nvim',
                config = function()
                    require('Comment').setup()
                end
            },
            { 'JoosepAlviste/nvim-ts-context-commentstring' }

        }
    })

    use({
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    })

    use {
        'prettier/vim-prettier',
        run = 'pnpm install',
        ft = { 'javascript', 'typescript', 'css', 'less', 'scss', 'graphql', 'markdown', 'vue', 'html', 'javascriptreact', 'typescriptreact', 'sql' }
    }

    use { "catppuccin/nvim", as = "catppuccin" }
    use { "maxmx03/solarized.nvim" }
    use { 'Exafunction/codeium.vim' }

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- Install vim-dadbod
    use {
        'tpope/vim-dadbod',
        config = function()
            -- Optional: configure vim-dadbod here if needed
        end
    }

    -- Install vim-dadbod-ui
    use {
        'kristijanhusak/vim-dadbod-ui',
        requires = 'tpope/vim-dadbod',
        config = function()
            -- Optional: configure vim-dadbod-ui here if needed
        end
    }

    -- Install vim-dadbod-completion
    use {
        'kristijanhusak/vim-dadbod-completion',
        requires = { 'tpope/vim-dadbod', 'hrsh7th/nvim-cmp' },
        config = function()
            -- Optional: configure vim-dadbod-completion here if needed
        end
    }

    use({
        'MeanderingProgrammer/markdown.nvim',
        as = 'render-markdown',                         -- Only needed if you have another plugin named markdown.nvim
        after = { 'nvim-treesitter' },
        requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
        -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
        -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
        config = function()
            require('render-markdown').setup({})
        end,
    })
end)
