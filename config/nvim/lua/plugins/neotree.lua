return {
   "nvim-neo-tree/neo-tree.nvim",
   branch = "v3.x",
   dependencies = {
       "nvim-lua/plenary.nvim",
       "MunifTanjim/nui.nvim",
       "nvim-tree/nvim-web-devicons", -- optional, but recommended
   },
   lazy = false, -- Loads the plugin immediately at startup 
    vim.keymap.set('n', '<leader>e', ':Neotree toggle position=left<CR>', { noremap = true, silent = true })
}
