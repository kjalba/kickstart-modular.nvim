-- 1. Enable visual "soft" wrapping
vim.opt_local.wrap = true

-- 2. Make wrapping smarter (break at words, not mid-word)
vim.opt_local.linebreak = true

-- 3. (Optional but nice) Show a symbol for wrapped lines
vim.opt_local.showbreak = '↪ '

-- 4. Disable "hard" wrapping
vim.opt_local.textwidth = 0

-- 5. Set format options (removed 't' for auto-hard-wrap)
vim.opt_local.formatoptions = 'cqn'
