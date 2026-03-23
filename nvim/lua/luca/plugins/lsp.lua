return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
    })

    -- Global capabilities applied to all servers
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- Per-server overrides
    vim.lsp.config("ts_ls", {
      single_file_support = false,
      root_markers = { "package.json" },
    })

    vim.lsp.config("denols", {
      root_markers = { "deno.json", "deno.jsonc", "mod.ts", "deps.ts", "import_map.json" },
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    vim.lsp.enable({
      "ts_ls",
      "denols",
      "eslint",
      "html",
      "cssls",
      "tailwindcss",
      "gopls",
      "pyright",
      "lua_ls",
      "jsonls",
      "yamlls",
      "taplo",
      "marksman",
    })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
      end,
    })

    vim.diagnostic.config({
      virtual_text = false,
      update_in_insert = true,
    })
  end,
}
