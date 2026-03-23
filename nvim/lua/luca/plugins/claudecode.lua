return {
  "coder/claudecode.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("claudecode").setup()
    vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })
    vim.keymap.set("n", "<leader>cf", "<cmd>ClaudeCodeFocus<CR>", { desc = "Focus Claude Code" })
    vim.keymap.set("v", "<leader>cs", "<cmd>ClaudeCodeSend<CR>", { desc = "Send selection to Claude" })
  end,
}
