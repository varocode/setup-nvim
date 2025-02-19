return {
	-- 📦 Configuración de herramientas con Mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				-- 🛠 Herramientas esenciales
				"stylua", -- Formateador de Lua
				"selene", -- Linter para Lua
				"luacheck", -- Linter para Lua
				"shellcheck", -- Linter para Bash
				"shfmt", -- Formateador para Bash
				"tailwindcss-language-server", -- LSP para TailwindCSS
				"typescript-language-server", -- LSP para TypeScript
				"css-lsp", -- LSP para CSS

				-- 📌 Nuevos servidores LSP añadidos
				"pyright", -- Python
				"rust-analyzer", -- Rust
				"jdtls", -- Java
				"bash-language-server", -- Bash
				"json-lsp", -- JSON
				"clangd", -- C y C++
				"marksman", -- Markdown
				"lemminx", -- XML
				"dockerfile-language-server", -- Docker
				"docker-compose-language-service", -- Docker Compose
				"taplo", -- TOML
				"gopls", -- Go
				"sqls", -- SQL
			})
		end,
	},

	-- 🚀 Configuración de servidores LSP
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false }, -- Desactiva las sugerencias en línea por defecto

			---@type lspconfig.options
			servers = {
				-- 📌 Servidores ya configurados
				cssls = {},
				html = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
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
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false, -- Evita que ordene las claves automáticamente
						},
					},
				},
				lua_ls = {
					single_file_support = true,
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							completion = { workspaceWord = true, callSnippet = "Both" },
							hint = {
								enable = true,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = { privateName = { "^_" } },
							type = { castNumberToInteger = true },
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},

				-- 📌 Nuevos servidores LSP añadidos
				pyright = {}, -- Soporte para Python
				rust_analyzer = {}, -- Soporte para Rust
				gopls = {}, -- Soporte para Go
				jdtls = { -- Configuración específica para Java
					cmd = { "jdtls" },
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git", "pom.xml", "gradle.build")(...)
					end,
					settings = {
						java = {
							format = {
								settings = {
									url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
								},
							},
						},
					},
				},
				bashls = {}, -- Soporte para Bash
				jsonls = {}, -- Soporte para JSON
				clangd = {}, -- Soporte para C y C++
				marksman = {}, -- Soporte para Markdown
				lemminx = {}, -- Soporte para XML
				dockerls = {}, -- Soporte para Docker
				docker_compose_language_service = {}, -- Soporte para Docker Compose
				sqls = {}, -- Soporte para SQL
				taplo = {}, -- Soporte para TOML
			},
			setup = {},
		},
	},

	-- 🏹 Configuración de atajos de teclado
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			vim.list_extend(keys, {
				{
					"gd",
					function()
						-- 🔍 No reutiliza la ventana actual para la definición
						require("telescope.builtin").lsp_definitions({ reuse_win = false })
					end,
					desc = "Ir a la Definición",
					has = "definition",
				},
			})
		end,
	},
}
