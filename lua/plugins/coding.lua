return {
	-- 📌 Generador de anotaciones en el código con una tecla
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Generar comentario con Neogen",
			},
		},
		opts = { snippet_engine = "luasnip" }, -- Usa Luasnip como motor de snippets
	},

	-- ✏️ Renombrado incremental con LSP
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
		keys = {
			{
				"<leader>rn",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "Renombrar símbolo con IncRename",
			},
		},
	},

	-- 🔨 Herramienta de refactorización
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	-- 📌 Movimiento entre elementos con corchetes `[]`
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	-- 🔢 Mejor incremento/decremento de números y valores
	{
		"monaqa/dial.nvim",
		keys = {
			{
				"<C-a>",
				function()
					return require("dial.map").inc_normal()
				end,
				expr = true,
				desc = "Incrementar número",
			},
			{
				"<C-x>",
				function()
					return require("dial.map").dec_normal()
				end,
				expr = true,
				desc = "Decrementar número",
			},
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal, -- Números decimales
					augend.integer.alias.hex, -- Números hexadecimales
					augend.date.alias["%Y/%m/%d"], -- Fechas en formato YYYY/MM/DD
					augend.constant.alias.bool, -- True/False alternables
					augend.semver.alias.semver, -- Versiones semánticas (1.0.0 -> 1.0.1)
					augend.constant.new({ elements = { "let", "const" } }), -- Alternar entre `let` y `const`
				},
			})
		end,
	},

	-- 📌 Vista estructurada de símbolos en el código
	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Ver símbolos del código" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right", -- Posiciona la vista en la derecha
		},
	},

	-- 🎭 Completado de emojis en `nvim-cmp`
	{
		"nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" }) -- Agrega emojis al autocompletado
		end,
	},
}
