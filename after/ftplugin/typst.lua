-- 1. SET EDITOR OPTIONS
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- 2. PREVIEW KEYMAP (this is your old, working keymap)
vim.keymap.set('n', '<leader>p', ':TypstPreview<CR>', {
  buffer = true,
  desc = '[P]review Typst document',
})

-- 3. EXPORT LOGIC (this is the new code you found)
local export_types = { 'pdf', 'png', 'svg', 'html' }

local function export(args)
  local target
  if vim.tbl_contains(export_types, args[1]) then
    target = args[1]
  elseif args[1] == nil then
    target = 'pdf'
  else
    print "Unsupported filetype. Use 'pdf' or 'png'."
    return
  end

  local filetype = vim.bo.filetype
  if filetype ~= 'typst' then
    print 'Current buffer is not a typst file'
    return
  end

  local current_file = vim.fn.expand '%:p'
  local cmd = 'typst compile --format ' .. target .. ' ' .. vim.fn.shellescape(current_file)

  print('Running: ' .. cmd)
  vim.fn.system(cmd)
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    print 'Typst compilation failed.'
  else
    print('Successfully exported to ' .. target)
  end
end

-- 4. TELESCOPE PICKER LOGIC (also from the new code)
local function export_picker()
  local filetype = vim.bo.filetype
  if filetype ~= 'typst' then
    print 'Current buffer is not a typst file'
    return
  end

  -- Require telescope parts inside the function
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  pickers
    .new({}, {
      prompt_title = 'Select Export Format',
      finder = finders.new_table {
        results = export_types,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          export { selection[1] }
        end)
        return true
      end,
    })
    :find()
end

-- 5. CREATE VIM COMMANDS
vim.api.nvim_create_user_command('Export', export, {
  nargs = '?',
  complete = function()
    return export_types
  end,
})
vim.api.nvim_create_user_command('ExportPicker', export_picker, {})

-- 6. EXPORT KEYMAP (this is the final piece)
vim.keymap.set('n', '<leader>ep', function()
  vim.cmd ':ExportPicker'
end, {
  buffer = true,
  desc = '[E]xport [P]roject',
})
