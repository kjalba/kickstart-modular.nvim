return {
  'thePrimeagen/harpoon',
  enabled = true,
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    local conf = require('telescope.config').values

    harpoon:setup {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    }

    -- NOTE: Experimenting
    -- Telescope into Harpoon function
    -- comment this function if you don't like it
    -- local function toggle_telescope(harpoon_files)
    -- 	local file_paths = {}
    -- 	for _, item in ipairs(harpoon_files.items) do
    -- 		table.insert(file_paths, item.value)
    -- 	end
    -- 	require("telescope.pickers")
    -- 		.new({}, {
    -- 			prompt_title = "Harpoon",
    -- 			finder = require("telescope.finders").new_table({
    -- 				results = file_paths,
    -- 			}),
    -- 			previewer = conf.file_previewer({}),
    -- 			sorter = conf.generic_sorter({}),
    -- 		})
    -- 		:find()
    -- end

    --Harpoon Nav Interface
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon add file' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    --Harpoon marked files
    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon switch to 1st file' })
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon switch to 2nd file' })
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon switch to 3rd file' })
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon switch to 4th file' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end)

    -- Telescope inside Harpoon Window
    -- vim.keymap.set("n", "<C-f>", function()
    -- 	toggle_telescope(harpoon:list())
    -- end)
  end,
}
