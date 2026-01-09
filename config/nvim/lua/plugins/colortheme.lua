return {
  'shaunsingh/nord.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- Example config in lua
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = true
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false

    -- Load the colorscheme
    require('nord').set()

    -- Toggle transparent background
    local transparent = true -- (default: true)
    local toggle_transparent = function()
        transparent = not transparent
        vim.g.nord_disable_background = transparent
        vim.cmd [[colorscheme nord]]
    end
    vim.keymap.set('n', '<leader>trans', toggle_transparent, { noremap = true, silent = true })
  end
}

