return {
	-- 🔥 Copilot + Integración con nvim-cmp
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = true }, -- Desactiva la UI nativa de Copilot
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- 🔹 Configuración de nvim-cmp con Copilot, LSP y Snippets mejorado
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip", -- Soporte para snippets
			"zbirenbaum/copilot-cmp", -- 🔥 Integración con Copilot
			"windwp/nvim-autopairs", -- 🔥 Integración con autopairs
			"hrsh7th/cmp-git", -- 🔥 Integración con Git para autocompletar en `gitcommit`
			"onsails/lspkind.nvim", -- 🔥 Íconos mejorados en autocompletado
			"j-hui/fidget.nvim", -- 🔥 Indicador de carga del LSP
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local lspkind = require("lspkind")

			-- 🔥 Cargar Fidget para mostrar la actividad de LSP
			require("fidget").setup({})

			cmp.setup({
				completion = {
					autocomplete = { "InsertEnter", "TextChanged" }, -- 🔥 Sugerencias automáticas
					keyword_length = 2, -- Muestra sugerencias después de 2 caracteres
				},
				experimental = {
					ghost_text = true, -- 🔥 Activa ghost text (como en VS Code)
				},
				window = {
					completion = cmp.config.window.bordered({
						border = { "", "─", "", "│", "", "─", "", "│" },
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = { "", "─", "", "│", "", "─", "", "│" },
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					}),
				},

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- Muestra íconos y nombres
						maxwidth = 50, -- Ancho máximo del menú
						ellipsis_char = "...", -- Texto si es demasiado largo
					}),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(), -- Abrir menú manualmente
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Up>"] = cmp.mapping.select_prev_item(), -- Moverse arriba con flecha ↑
					["<Down>"] = cmp.mapping.select_next_item(), -- Moverse abajo con flecha ↓
					["<Esc>"] = cmp.mapping.close(), -- Cerrar menú con Escape

					-- 🔥 Navegación mejorada con Tab y Shift-Tab
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "copilot", priority = 10000, group_index = 1 }, -- 🔥 Copilot integrado en cmp
					{ name = "nvim_lsp", priority = 9000, group_index = 2 }, -- LSP (servidor de lenguaje)
					{ name = "luasnip", priority = 7500, group_index = 3 }, -- Snippets
					{ name = "buffer", priority = 5000, group_index = 4 }, -- 🔥 Optimizado
					{ name = "path", priority = 2500, group_index = 5 }, -- Autocompletado de rutas
					{ name = "git", priority = 1000, group_index = 6 }, -- Autocompletado en gitcommit
				}),
			})

			-- 🔥 Autocompletado en la línea de comandos (`:`)
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline" },
					{ name = "path" },
				}),
			})

			-- 🔥 Autocompletado en la búsqueda (`/`)
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- 🔥 Conectar Autopairs con la confirmación de selección
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- 🔥 Autocompletado optimizado en Markdown y comentarios
			cmp.setup.filetype({ "markdown", "text", "gitcommit", "plaintext" }, {
				sources = cmp.config.sources({
					{ name = "buffer" }, -- 🔥 Enfoca el autocompletado en el texto del buffer
				}),
			})
		end,
	},
}
