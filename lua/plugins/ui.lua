return {
	-- Notificaciones mejoradas con Noice y Notify
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	-- Sistema de comentarios TODO, FIX, HACK, etc.
	{ "folke/todo-comments.nvim", version = "*" },

	-- Popup de atajos con which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "classic",
			win = { border = "single" },
		},
	},

	-- Línea de estado personalizable con Lualine
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		opts = {
			options = {
				theme = "oldworld",
				icons_enabled = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icon = "🚀",
					},
				},
			},
		},
	},

	-- Bufferline para gestión de pestañas
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Siguiente tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Tab anterior" },
		},
		opts = {
			options = {
				mode = "tabs",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- Visualización del nombre del archivo flotante con Incline
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		config = function()
			require("incline").setup({
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	-- Modo Zen para concentración
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
				twilight = { enabled = true }, -- Activa Twilight para oscurecer el fondo
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Modo Zen" } },
	},

	-- Snacks: Mejoras en la interfaz de usuario
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				preset = {
					header = [[
					                                                                                 
██╗   ██╗ █████╗ ██████╗  ██████╗        ██████╗ ██████╗ ██████╗ ███████╗
██║   ██║██╔══██╗██╔══██╗██╔═══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
██║   ██║███████║██████╔╝██║   ██║█████╗██║     ██║   ██║██║  ██║█████╗  
╚██╗ ██╔╝██╔══██║██╔══██╗██║   ██║╚════╝██║     ██║   ██║██║  ██║██╔══╝  
 ╚████╔╝ ██║  ██║██║  ██║╚██████╔╝      ╚██████╗╚██████╔╝██████╔╝███████╗
  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝        ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝

"El crecimiento es la acumulación de pequeños esfuerzos diarios"
                                                               
]],
				},
				sections = {
					{ section = "header" },
					{
						pane = 2,
						section = "terminal",
						cmd = "/home/varodev/.local/bin/colorscript -e pinguco",
						height = 10,
						padding = 1,
					},
					{ section = "keys", gap = 1, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
				},
			},
			explorer = { enabled = false },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			picker = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},
}
