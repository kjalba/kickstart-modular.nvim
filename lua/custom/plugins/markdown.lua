return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    code = {
      enabled = true,
      render_modes = false,
      sign = true,
      style = 'full',
      position = 'left',
      language_pad = 0,
      language_icon = true,
      language_name = true,
      disable_background = { 'diff' },
      width = 'full',
      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = 'hide',
      above = '▄',
      below = '▀',
      inline_left = '',
      inline_right = '',
      inline_pad = 0,
      highlight = 'RenderMarkdownCode',
      highlight_language = nil,
      highlight_border = 'RenderMarkdownCodeBorder',
      highlight_fallback = 'RenderMarkdownCodeFallback',
      highlight_inline = 'RenderMarkdownCodeInline',
    },
  },
}
