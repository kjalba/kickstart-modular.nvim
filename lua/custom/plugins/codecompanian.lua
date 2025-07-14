return {
  {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'j-hui/fidget.nvim', -- To display status messages
      'ravitemer/codecompanion-history.nvim', -- To save and load conversation history
      {
        'ravitemer/mcphub.nvim', -- Manages connections to AI providers
        cmd = 'MCPHub',
        build = 'npm install -g mcp-hub@latest',
        config = true,
      },
      {
        'HakonHarnes/img-clip.nvim', -- Optional: for pasting images in chat
        event = 'VeryLazy',
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = '[Image]($FILE_PATH)',
              use_absolute_path = true,
            },
          },
        },
      },
    },
    opts = {
      -- Tell CodeCompanion to use mcphub to discover available AI models
      -- and to create slash commands for them automatically.
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        -- Enable the history extension
        history = {
          enabled = true,
          opts = {
            dir_to_save = vim.fn.stdpath 'data' .. '/codecompanion-history',
          },
        },
      },

      -- Define the connection details for each AI provider you want to use.
      -- These are passed to mcphub.
      adapters = {
        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            env = {
              -- This command fetches your API key from 1Password.
              -- Ensure the path 'op://personal/Gemini_API/credential' is correct!
              api_key = 'cmd:op read op://Personal/Gemini_API/credential --no-newline',
            },
            -- You can optionally set a default model here if you prefer
            -- schema = {
            --   model = {
            --     default = 'gemini-1.5-pro-latest', -- or 'gemini-1.5-flash-latest'
            --   },
            -- },
          })
        end,
        -- You can add other providers here (e.g., openai, anthropic)
        -- in the same way.
      },

      -- *** THIS IS THE CRITICAL FIX ***
      -- Strategies tell CodeCompanion which adapter and model to use for different tasks.
      strategies = {
        -- Use the 'gemini' adapter for all chat-related actions.
        chat = {
          adapter = {
            name = 'gemini',
            -- You could override the model here, e.g., model = 'gemini-1.5-flash-latest'
          },
          -- Optional: Customize keymaps for the chat window
          keymaps = {
            send = {
              modes = {
                i = { '<C-Enter>' }, -- Send message with Ctrl+Enter in insert mode
              },
            },
          },
        },
        -- You could define other strategies, e.g., for inline code generation
        -- inline = {
        --   adapter = { name = 'gemini', model = 'gemini-1.5-flash-latest' }
        -- },
      },

      -- Configure how UI elements should look and feel.
      display = {
        chat = {
          show_settings = true, -- Shows a header with the current adapter/model
        },
        diff = {
          -- Use nvim-dap-ui's diff view if available, otherwise built-in.
          provider = 'diffview.nvim',
        },
        action_palette = {
          -- Use Neovim's built-in picker. You can change this to 'fzf' or 'telescope'.
          provider = 'default',
        },
      },

      -- Set to 'INFO' or 'WARN' in normal use to reduce noise.
      opts = {
        log_level = 'DEBUG',
      },
    },
    -- Keymaps to open and interact with CodeCompanion
    keys = {
      {
        '<leader>ca',
        '<cmd>CodeCompanionActions<CR>',
        desc = '[C]ode [A]ctions',
        mode = { 'n', 'v' },
      },
      {
        '<leader>cc',
        '<cmd>CodeCompanionChat<CR>',
        desc = '[C]ode [C]hat',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ci',
        function()
          require('codecompanion').inline()
        end,
        desc = '[C]ode [I]nline',
        mode = { 'n', 'v' },
      },
    },
    init = function()
      -- Optional: Create a shorter command alias
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
}
