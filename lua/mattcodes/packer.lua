local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
        vim.cmd [[packeradd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'numToStr/Comment.nvim',
    }
    use 'rstacruz/vim-closer'

    use 'lukas-reineke/indent-blankline.nvim'
    use 'HiPhish/rainbow-delimiters.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
    }

    use {
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    }

    use 'lewis6991/gitsigns.nvim'
    use { 'catppuccin/nvim', { as = 'catppuccin' } }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context'

    -- LSP Manager
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        },
    }
    use 'mfussenegger/nvim-lint'
    use 'stevearc/conform.nvim'
    use {
        'pmizio/typescript-tools.nvim',
        requires = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
        },
    }

    use 'folke/neodev.nvim'

    use 'tpope/vim-fugitive'

    use { 'akinsho/toggleterm.nvim', tag = '*' }

    use 'nvim-lua/plenary.nvim'
    use 'ThePrimeagen/harpoon'

    use {
        'SmiteshP/nvim-navic',
        requires = {
            'neovim/nvim-lspconfig',
        },
    }

    use 'kyazdani42/nvim-web-devicons'

    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
    }

    use {
        'stevearc/oil.nvim',
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
