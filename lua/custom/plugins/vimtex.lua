---@diagnostic disable: undefined-global
---
return {
  {
    'lervag/vimtex',
    lazy = false,
    -- tag = "v2.17", -- uncomment to pin to a specific release
    init = function()
      --global vimtex settings
      vim.g.vimtex_imaps_enabled = 0 --i.e., disable them

      --vimtex_view_settings
      vim.g.vimtex_view_method = 'skim' -- <-- THIS IS THE ONLY LINE NEEDED

      --quickfix settings
      vim.g.vimtex_quickfix_open_on_warning = 0 --  don't open quickfix if there are only warnings
      vim.g.vimtex_quickfix_ignore_filters =
        { 'Underfull', 'Overfull', 'LaTeX Warning: .\\+ float specifier changed to', 'Package hyperref Warning: Token not allowed in a PDF string' }
    end,
  },
}
