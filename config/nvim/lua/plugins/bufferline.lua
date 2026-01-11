return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup({
            options = {
                mode = "buffers", -- shows buffers [ "tabs" will show tab pages]
--                style_preset = bufferline.style_preset.default, -- predefined default UI styles
                themable = true, -- allows custom colour themes to override it
                numbers = "none", -- number shown on each buffer. other options = ordinal, buffer_id, both, function(...)
                
                -- Mouse actions
                close_command = "bdelete! %d", -- force deletes buffer on clicking 'x'
                right_mouse_command = false, -- right mouse key is disabled
                left_mouse_command = "buffer %d", -- left mouse key focuses the buffer
                middle_mouse_command = false, -- middle mouse key is disabled

                indicator = {
                   -- icon = ' ', -- ignored if style ~= icon 
                    style = 'none' -- other options: icon, underline, none
                },

                -- Icons
                buffer_close_icon = '󰅖',
                modified_icon = '●',
                close_icon = ' ',
                left_trunc_marker = ' ',
                right_trunc_marker = ' ',

                color_icons = true,
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = false,
                show_tab_indicators = true,

                -- Buffer name formatting (function returns a formatted string)
                -- name_formatter = function(buf)
                -- end,

                max_name_length = 18,
                max_prefix_length = 15,
                truncate_names = true,
                tab_size = 18,

                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = {"close"},
                },

                -- Diagnostics integration
                diagnostics = false, -- other options: nvim_lsp, coc
                -- avoids flicker while typing
                diagnostics_update_in_insert = false,
                diagnostics_update_on_event = true,
                -- custom text shown when a buffer has errors/warnings
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    return "(" .. count .. ")"
                end,

                -- Offsets (for file explorers like NeoTree)
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-Tree FileExplorer",
                        text_align = "left",
                        separator = true
                    }
                },

                -- sorting and movement
                persist_buffer_sort = true, -- keeps custom buffer order across sessions
                move_wraps_at_ends = false, -- first/last buffer wraps around

                separator_style = "slope", -- options: slant | slope | thick | thin | { any, any }
                

                always_show_bufferline = false,
                auto_toggle_bufferline = true,

                minimum_padding = 1,
                maximum_padding = 5,
                maximum_length = 15,
                sort_by = 'insert_at_end',

            },
            highlights = {
                separator = {
                    fg = '#00fff3',
                },
                buffer_selected = {
                    bold = true,
                    italic = false
                },
                -- separator_selected = {},
                -- tab_selected = {},
                -- background = {},
                -- indicator_selected = {},
                -- fill = {},
            }
        })
    end
}
