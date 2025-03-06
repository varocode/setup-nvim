return {
	-- 📦 Instalación de herramientas con Mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"stylua", -- Formateador para Lua
				"shellcheck", -- Linter para Bash
				"shfmt", -- Formateador para Bash
				"vtsls", -- 🔥 Servidor correcto para TypeScript en Mason
				"css-lsp", -- LSP para CSS
				"html-lsp", -- LSP para HTML
				"tailwindcss-language-server", -- LSP para TailwindCSS
				"pyright", -- LSP para Python
				"rust-analyzer", -- LSP para Rust
				"jdtls", -- LSP para Java
				"bash-language-server", -- LSP para Bash
				"json-lsp", -- LSP para JSON
				"clangd", -- LSP para C/C++
				"marksman", -- LSP para Markdown
				"lemminx", -- LSP para XML
				"dockerfile-language-server", -- LSP para Docker
				"docker-compose-language-service", -- LSP para Docker Compose
				"taplo", -- LSP para TOML
				"gopls", -- LSP para Go
				"sqls", -- LSP para SQL
			})
		end,
	},

	-- 🚀 Configuración de Mason-LSPConfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 🔥 Servidores LSP configurados en Mason-LSPConfig
			local servers = {
				"vtsls", -- 🔥 Reemplazo de "tsserver"
				"html",
				"cssls",
				"pyright",
				"bashls",
				"lua_ls",
				"jsonls",
				"clangd",
				"marksman",
				"lemminx",
				"dockerls",
				"docker_compose_language_service",
				"sqls",
				"taplo",
				"rust_analyzer",
				"gopls",
				"jdtls",
			}

			-- 📌 Configurar servidores válidos en Mason-LSPConfig
			mason_lspconfig.setup({
				ensure_installed = servers,
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})
		end,
	},

	-- 🎯 Configuración adicional para LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 🔥 Configuración específica para TypeScript con VTSLS
			lspconfig.vtsls.setup({
				capabilities = capabilities,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "literal",
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			})

			-- 📌 Configuración específica para HTML
			lspconfig.html.setup({
				filetypes = { "html", "htmldjango" },
				settings = {
					html = {
						validate = { scripts = true, styles = true },
						format = {
							enable = true,
							indentInnerHtml = true,
							wrapLineLength = 120,
							preserveNewLines = true,
							unformatted = "pre,code,textarea",
						},
					},
				},
			})
		end,
	},

	-- 🎯 Atajos de teclado para LSP
	{
		"neovim/nvim-lspconfig",
		opts = {
			keys = {
				{
					"gd",
					function()
						require("telescope.builtin").lsp_definitions({ reuse_win = false })
					end,
					desc = "Ir a la Definición",
					has = "definition",
				},
				{ "K", vim.lsp.buf.hover, desc = "Mostrar documentación" },
				{ "<leader>rn", vim.lsp.buf.rename, desc = "Renombrar símbolo" },
				{
					"gr",
					function()
						require("telescope.builtin").lsp_references()
					end,
					desc = "Buscar referencias",
				},
			},
		},
	},
}
