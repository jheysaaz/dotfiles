return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("oil").setup({
      view_options = { show_hidden = true },
    })
    vim.keymap.set("n", "<leader>ee", "<cmd>Oil<CR>", { desc = "Open file explorer" })
    vim.keymap.set("n", "<leader>ef", require("oil").open_float, { desc = "Open file explorer (float)" })
  end,
}
