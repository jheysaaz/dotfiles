return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  keys = {
    { "<leader>ee", "<cmd>Oil<CR>", desc = "Open file explorer" },
    { "<leader>ef", function() require("oil").open_float() end, desc = "Open file explorer (float)" },
  },
  config = function()
    require("oil").setup({
      view_options = { show_hidden = true },
    })
  end,
}
