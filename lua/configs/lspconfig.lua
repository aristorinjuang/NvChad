require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "gopls",
  "lua_ls",
  "intelephense",
  "eslint",
  "ts_ls",
  "tailwindcss",
  "pylsp",
  "angularls"
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }


local golangci_config = {
  cmd = {'golangci-lint-langserver'},
  filetypes = { 'go', 'gomod' },
  root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
  init_options = {
    command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" };
  }
};
if not configs.golangcilsp then
  configs.golangcilsp = {
    default_config = golangci_config
  }
end
lspconfig.golangci_lint_ls.setup {
  filetypes = golangci_config.filetypes,
  root_dir = golangci_config.root_dir,
  init_options = golangci_config.init_options
}

lspconfig.volar.setup {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  init_options = {
    vue = {
      hybridMode = false
    },
    typescript = {
      tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"
    }
  }
}
