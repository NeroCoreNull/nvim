return {
    -- 'AlexvZyl/nordic.nvim',
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- require 'nordic' .load()
        require 'catppuccin' .load()
    end
}
