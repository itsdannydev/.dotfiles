-- plugin to auto close HTML tags, it also renames closing tags if the opening tag was edited
-- Eg: <h1> + Enter => <h1>|</h1> 

return {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('nvim-ts-autotag').setup({
            opts = {
                -- Defaults
                enable_close = true, -- auto closes tags. <div>| -> <div>|</div>
                enable_rename = true, -- auto renames the pairs of tags
                enable_close_on_slash = false -- auto close on trailing </. <div>...</| -> <div>...</div>
            },
            -- per file configs. These take priority over defaults
            per_filetype = {
                ["html"] = {
                    enable_close = true,
                }
            }
--            enable=true,
--            enable_close = true,
--            enable_rename = true,
--            enable_close_on_slash = true,
        })
   end
}
