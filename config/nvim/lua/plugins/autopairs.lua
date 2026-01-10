return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    lazy = false,
    config = function()
        require('nvim-autopairs').setup({
            enabled = function(bufnr) return true end, -- control if auto-pairs should be enabled when attaching to a buffer
            disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
            disable_in_macro = true, -- disable when recording or executing a macro
            disable_in_visualblock = false, -- disable autopairs in visual mode
            disable_in_replace_mode = true,
            ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
            enable_moveright = true, -- (|) typing ) will move to right instead of inserting another )

            enable_afterquote = true, -- add bracket pairs after quote
            enable_check_bracket_line = true, --- check bracket in same line
            enable_bracket_in_quote = true, --
            enable_abbr = false, -- trigger abbreviation
            break_undo = true, -- typing {} becomes one step, cursor movement is separate step. (undo feels natural)
            check_ts = false,
            map_cr = true,
            map_bs = true, -- map the <BS> key ( deletes the pair {|} )
            map_c_h = false, -- Map the <C-h> key to delete a pair
            map_c_w = false, -- map <c-w> to delete a pair if possible
        })
    end
}
