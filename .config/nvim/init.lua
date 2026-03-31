-- =============================================================================
-- LEADER
-- =============================================================================
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"


-- =============================================================================
-- PLUGINS
-- =============================================================================
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
        if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
        vim.cmd('TSUpdate')
    end
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
        vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end
end })

vim.pack.add({
    {
        src = 'https://github.com/saghen/blink.cmp',
        version = vim.version.range('1.*'),
    },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/ellisonleao/gruvbox.nvim.git",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/folke/trouble.nvim",
    'https://github.com/alexghergh/nvim-tmux-navigation',
})

-- =============================================================================
-- OPTIONS
-- =============================================================================
vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.tabstop = 4        -- how wide a tab character looks
vim.opt.shiftwidth = 4     -- how many spaces for each indent level
vim.opt.softtabstop = 4    -- how many spaces a <Tab> keypress inserts
vim.cmd.colorscheme("gruvbox")

-- =============================================================================
-- KEYMAPS
-- =============================================================================
local opts = { noremap = true, silent = false }
vim.keymap.set('i', 'jj', "<Esc>", opts)
vim.keymap.set('n', '\\', '<cmd> Neotree toggle<cr>', opts)

-- =============================================================================
-- PLUGIN CONFIGURATION
-- =============================================================================
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-k>'] = require('telescope.actions').move_selection_previous,
                ['<C-j>'] = require('telescope.actions').move_selection_next,
                ['<C-l>'] = require('telescope.actions').select_default,
            },
        },
    },
    pickers = {
        find_files = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            hidden = true,
        },
        live_grep = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            additional_args = function(_)
                return { '--hidden' }
            end,
        },
    },
}

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- =============================================================================
-- LSP
-- =============================================================================
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    end
})

vim.lsp.enable("basedpyright")

require('nvim-treesitter').setup({
    ensure_installed = { 'python', 'lua', 'vimdoc', 'javascript', 'typescript' },
    highlight = { enable = true },
})

require('trouble').setup({})
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ...' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

require('nvim-tmux-navigation').setup({
    disable_when_zoomed = true,
    keybindings = {
        left = '<C-h>',
        down = '<C-j>',
        up = '<C-k>',
        right = '<C-l>',
        last_active = '<C-\\>',
    },
})

require('blink.cmp').setup({
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono',
    },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
})
