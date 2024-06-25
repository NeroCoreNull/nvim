return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = { theme = 'horizon' },
            sections = {
		        lualine_x = {
                    "encoding", {
                        "fileformat", symbols = { unix = "" }
                    },"filetype"
                },
	        },
        })
    end
}
