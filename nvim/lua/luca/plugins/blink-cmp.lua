return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  opts = {
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
    },
  },
}
