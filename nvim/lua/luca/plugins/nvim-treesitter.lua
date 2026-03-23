return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "javascript",
          "typescript",
          "tsx",
          "vue",
          "json",
          "yaml",
          "html",
          "css",
          "markdown",
          "markdown_inline",
          "svelte",
          "graphql",
          "bash",
          "fish",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "query",
          "go",
          "python",
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })

      require("nvim-ts-autotag").setup()
    end,
  },
}
