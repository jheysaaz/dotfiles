local options = {
  -- Colors
  background = "light",
  termguicolors = true,

  -- Indentation
  tabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  autoindent = true,

  -- Clipboard
  clipboard = "unnamedplus",

  -- UI
  mouse = "a",
  numberwidth = 2,
  showmode = false,
  cursorline = true,
  relativenumber = true,
  list = true,
  listchars = "tab:» ,space:⋅",
  completeopt = { "menu", "menuone", "noinsert", "noselect" },

  -- Others
  swapfile = false,
  updatetime = 250,
}

for o, v in pairs(options) do
  vim.opt[o] = v
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "txt", "gitcommit", "help" },
  callback = function()
    vim.wo.wrap = true
  end,
})
