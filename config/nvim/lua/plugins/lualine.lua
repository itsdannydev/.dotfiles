return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 
        'nvim-tree/nvim-web-devicons' 
    },
    config = function()
        -- custom color theme for lualine
        local custom_theme = require('themes.lualine.danny_cyan')
        
        -- modified components
        local mode = {
            'mode',
            fmt = function(str)
                return ' ' .. str
            end
        }

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'iceberg_dark',
--                theme = custom_theme,
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                  statusline = 1000,
                  tabline = 1000,
                  winbar = 1000,
                  refresh_time = 16, -- ~60fps
                  events = {
                    'WinEnter',
                    'BufEnter',
                    'BufWritePost',
                    'SessionLoadPost',
                    'FileChangedShellPost',
                    'VimResized',
                    'Filetype',
                    'CursorMoved',
                    'CursorMovedI',
                    'ModeChanged',
                  },
                }
              },
              sections = {
                lualine_a = { mode },
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
              },
              inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
              },
              tabline = {},
              winbar = {},
              inactive_winbar = {},
              extensions = {}
            }
    end
}
