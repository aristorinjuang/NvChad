require("nvchad.configs.lspconfig").defaults()

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "gopls",
  "lua_ls",
  "intelephense",
  "eslint",
  "tailwindcss",
  "pylsp",
  "angularls"
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config using new vim.lsp.config API
for _, lsp in ipairs(servers) do
  vim.lsp.config[lsp] = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
  vim.lsp.enable(lsp)
end

-- configuring single server, example: typescript
-- vim.lsp.config.ts_ls = {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
-- vim.lsp.enable('ts_ls')

-- golangci-lint language server
vim.lsp.config.golangci_lint_ls = {
  cmd = {'golangci-lint-langserver'},
  filetypes = { 'go', 'gomod' },
  root_dir = function(fname)
    return vim.fs.root(fname, {'.git', 'go.mod'})
  end,
  init_options = {
    command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" };
  }
}
vim.lsp.enable('golangci_lint_ls')

-- Vue.js support with vue_ls (formerly volar)
vim.lsp.config.vue_ls = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "vue" },
}
vim.lsp.enable('vue_ls')

-- TypeScript support including Vue files
vim.lsp.config.ts_ls = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
        languages = { "vue" },
      },
    },
  },
}
vim.lsp.enable('ts_ls')
