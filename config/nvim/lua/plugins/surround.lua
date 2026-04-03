return {
  'echasnovski/mini.surround',
  version = false,
  config = function()
    require('mini.surround').setup({
      mappings = {
        add = 'sa',       -- add surround
        delete = 'sd',    -- delete surround
        replace = 'sr',   -- replace surround
        find = 'sf',
        find_left = 'sF',
        highlight = 'sh',
        update_n_lines = 'sn',
      },
    })
  end,
}


