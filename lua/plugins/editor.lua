return {
	{
		enabled = false,
		"folke/flash.nvim",
		---@type Flash.Config
		opts = {
			search = {
				forward = true, -- Habilitar búsqueda hacia adelante
				multi_window = false, -- No buscar en múltiples ventanas
				wrap = false, -- No envolver búsqueda
				incremental = true, -- Búsqueda incremental
			},
		},
	},

	{
		-- Plugin: goto-preview
		-- URL: https://github.com/rmagatti/goto-preview
		-- Description: Provides preview functionality for definitions, declarations, implementations, type definitions, and references.
		"rmagatti/goto-preview",
		event = "BufEnter", -- Load the plugin when a buffer is entered
		config = true, -- Enable default configuration
		keys = {
			{
				"gpd",
				"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
				noremap = true, -- Do not allow remapping
				desc = "goto preview definition", -- Description for the keybinding
			},
			{
				"gpD",
				"<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
				noremap = true,
				desc = "goto preview declaration",
			},
			{
				"gpi",
				"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
				noremap = true,
				desc = "goto preview implementation",
			},
			{
				"gpy",
				"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
				noremap = true,
				desc = "goto preview type definition",
			},
			{
				"gpr",
				"<cmd>lua require('goto-preview').goto_preview_references()<CR>",
				noremap = true,
				desc = "goto preview references",
			},
			{
				"gP",
				"<cmd>lua require('goto-preview').close_all_win()<CR>",
				noremap = true,
				desc = "close all preview windows",
			},
		},
	},

	-- 📌 Resaltado de colores HSL en el código
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre", -- Cargar antes de leer un buffer
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)", -- Detectar patrones de color HSL
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						--- @type string, string, string
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		},
	},

	-- 📌 Integración con Git en Neovim
	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre", -- Cargar antes de leer un buffer
		opts = {
			keymaps = {
				blame = "<Leader>gb", -- Mostrar el historial de cambios de una línea
				browse = "<Leader>go", -- Abrir el archivo en el repositorio Git remoto
			},
		},
	},

	-- 🔎 Búsqueda avanzada con Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make", -- Requiere `make` para compilar
			},
			"nvim-telescope/telescope-file-browser.nvim", -- Explorador de archivos con Telescope
		},
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
				end,
				desc = "Buscar archivos en la carpeta de plugins",
			},
			{
				";f",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({
						no_ignore = false,
						hidden = true,
					})
				end,
				desc = "Listar archivos en el directorio actual",
			},
			{
				";r",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep({
						additional_args = { "--hidden" },
					})
				end,
				desc = "Buscar una cadena en los archivos abiertos",
			},
			{
				"\\\\",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "Listar buffers abiertos",
			},
			{
				";t",
				function()
					local builtin = require("telescope.builtin")
					builtin.help_tags()
				end,
				desc = "Buscar en la documentación de Neovim",
			},
			{
				";;",
				function()
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Reanudar la última búsqueda en Telescope",
			},
			{
				";e",
				function()
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
				desc = "Listar diagnósticos de errores y advertencias",
			},
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Listar nombres de funciones y variables con Treesitter",
			},
			{
				"sf",
				function()
					local telescope = require("telescope")

					local function telescope_buffer_dir()
						return vim.fn.expand("%:p:h")
					end

					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = telescope_buffer_dir(),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal",
						layout_config = { height = 40 },
					})
				end,
				desc = "Abrir explorador de archivos en la carpeta actual",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				wrap_results = true, -- Ajustar resultados al ancho de la pantalla
				layout_strategy = "horizontal", -- Distribución horizontal de los resultados
				layout_config = { prompt_position = "top" }, -- Ubicar el prompt arriba
				sorting_strategy = "ascending", -- Orden ascendente de los resultados
				winblend = 0, -- Transparencia en ventanas flotantes
				mappings = {
					n = {},
				},
			})
			opts.pickers = {
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
					layout_config = {
						preview_cutoff = 9999,
					},
				},
			}
			opts.extensions = {
				file_browser = {
					theme = "dropdown", -- Diseño tipo dropdown
					hijack_netrw = true, -- Desactivar netrw y usar file-browser en su lugar
					hidden = true, -- Mostrar archivos ocultosq
					mappings = {
						["n"] = {
							["N"] = fb_actions.create, -- Crear nuevo archivo
							["h"] = fb_actions.goto_parent_dir, -- Subir al directorio padre
							["/"] = function()
								vim.cmd("startinsert") -- Activar modo insert
							end,
							["<C-u>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_previous(prompt_bufnr)
								end
							end,
							["<C-d>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_next(prompt_bufnr)
								end
							end,
							["<PageUp>"] = actions.preview_scrolling_up,
							["<PageDown>"] = actions.preview_scrolling_down,
						},
					},
				},
			}
			telescope.setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
	},

	-- ✨ Mejoras en el autocompletado con Blink.cmp
	{
		"saghen/blink.cmp",
		opts = {
			completion = {
				menu = {
					winblend = vim.o.pumblend, -- Ajustar transparencia en el menú de autocompletado
				},
			},
			signature = {
				window = {
					winblend = vim.o.pumblend, -- Ajustar transparencia en la vista previa de funciones
				},
			},
		},
	},
}
