require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "dockerls", "docker_compose_language_service", "tailwindcss-language-server" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
