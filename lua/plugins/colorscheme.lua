return {
	{
		{
			-- 🌟 Plugin para habilitar la transparencia en Neovim
			"xiyaowong/transparent.nvim",
			-- event = "VeryLazy", -- Se carga cuando abres un archivo
			-- lazy = true, -- Se asegura que no cargue en el arranque
			config = function()
				require("transparent").setup({
					enable = true, -- Habilita la transparencia en Neovim
					extra_groups = { -- Lista de grupos de resaltado que serán transparentes
						"Normal",
						"NormalNC",
						"Comment",
						"Constant",
						"Special",
						"Identifier",
						"Statement",
						"PreProc",
						"Type",
						"Underlined",
						"Todo",
						"String",
						"Function",
						"Conditional",
						"Repeat",
						"Operator",
						"Structure",
						"LineNr",
						"NonText",
						"SignColumn",
						"CursorLineNr",
						"EndOfBuffer",
						"NormalFloat",
						"NvimTreeNormal",
						"FloatBorder",
						"Pmenu", -- 🔥 Fondo del menú de autocompletado
					},
					exclude_groups = {}, -- Lista de grupos de resaltado que NO deben ser transparentes
				})
				vim.cmd("TransparentEnable") -- Ejecuta el comando para habilitar la transparencia
			end,
		},

		-- 🎨 Plugin para manejar temas con "lush.nvim"
		{ "rktjmp/lush.nvim" },

		-- 🌸 Tema Sakura: se establece como predeterminado
		"anAcc22/sakura.nvim",
		config = function()
			vim.opt.background = "dark" -- Usa fondo oscuro
			vim.cmd("colorscheme sakura") -- Aplica el tema Sakura
		end,
	},

	-- 🏛 Tema OldWorld (Se establece como el tema predeterminado)
	{
		"dgox16/oldworld.nvim",
		lazy = false, -- Carga el tema inmediatamente
		priority = 1000, -- Prioridad alta para que se cargue primero
		opts = {
			variant = "oled", -- Configura el tema en su variante "oled"
		},
	},

	{
		-- ⚙ Configuración de LazyVim
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "kanagawa", -- Se configura OldWorld como el tema predeterminado
		},
	},

	-- 🌙 TEMAS ADICIONALES (Comentados, puedes activarlos si los necesitas)

	-- {
	-- 	-- 🎨 Tema Catppuccin con soporte para transparencia y varias variantes
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false, -- Cargar de inmediato
	-- 	opts = {
	-- 		transparent_background = true, -- Habilita fondo transparente
	-- 		flavour = "mocha", -- Establece la variante "mocha"
	-- 	},
	-- },

	{
		-- 🎨 Tema Kanagawa: Esquema de color japonés con transparencias y personalización avanzada
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 1000, -- Alta prioridad para cargarlo temprano
		opts = {
			transparent = true, -- Habilita la transparencia
			theme = "dragon", -- Usa la variante "dragon" del tema
		},
	},

	-- {
	-- 	-- 🌿 Tema Everforest con fondo "hard" y transparencias opcionales
	-- 	"neanias/everforest-nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("everforest").setup({
	-- 			background = "hard", -- Fondo en modo "hard"
	-- 			italics = true, -- Habilita cursivas
	-- 			transparent_background_level = 1, -- Niveles de transparencia
	-- 		})
	-- 	end,
	-- },

	-- {
	-- 	-- 🌃 Tema TokyoNight, moderno y con opciones de personalización
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		bold = true,
	-- 		italic = true,
	-- 		transparent = true, -- Fondo transparente
	-- 	},
	-- },
	--
	-- {
	-- 	-- 🌹 Tema Rose Pine con variante "moon" y opciones de transparencia
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	opts = {
	-- 		variant = "moon", -- Usa la variante "moon"
	-- 		styles = {
	-- 			bold = true,
	-- 			italic = true,
	-- 			transparency = true, -- Activa transparencia
	-- 		},
	-- 	},
	-- },
}
