return {
	-- 📌 Plugin: nvim-treesitter/playground
	-- Permite visualizar y analizar el árbol de sintaxis generado por Treesitter.
	-- Comando disponible: `:TSPlaygroundToggle`
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		-- 📌 Plugin: nvim-treesitter/nvim-treesitter
		-- Habilita Treesitter en Neovim para un resaltado de sintaxis avanzado, 
		-- mejor reconocimiento de estructuras de código y análisis profundo.
		"nvim-treesitter/nvim-treesitter",
		opts = {
			-- 🔹 Lenguajes que se instalarán automáticamente
			ensure_installed = {
				"astro",
				"cmake",
				"cpp",
				"css",
				"fish",
				"gitignore",
				"go",
				"graphql",
				"http",
				"java",
				"php",
				"rust",
				"scss",
				"sql",
				"svelte",
			},

			-- 🔎 Linter de consultas de Treesitter
			-- Permite detectar errores en las consultas de Treesitter en tiempo real.
			query_linter = {
				enable = true, -- Habilitar el linter
				use_virtual_text = true, -- Mostrar los errores en texto virtual dentro del código
				lint_events = { "BufWrite", "CursorHold" }, -- Eventos que activan el análisis
			},

			-- 🎨 Configuración del Playground de Treesitter
			-- Permite inspeccionar y visualizar la estructura sintáctica de los archivos abiertos.
			playground = {
				enable = true, -- Habilitar el Playground de Treesitter
				disable = {}, -- Lista de lenguajes donde se deshabilita (vacío significa que está activo en todos)
				updatetime = 25, -- Tiempo de actualización para resaltar nodos en el Playground
				persist_queries = true, -- Mantener las consultas de Treesitter entre sesiones de Neovim
				
				-- 🔹 Atajos de teclado para el Playground
				keybindings = {
					toggle_query_editor = "o", -- Alternar editor de consultas
					toggle_hl_groups = "i", -- Alternar grupos de resaltado
					toggle_injected_languages = "t", -- Alternar lenguajes inyectados
					toggle_anonymous_nodes = "a", -- Alternar nodos anónimos
					toggle_language_display = "I", -- Alternar visualización de lenguajes
					focus_language = "f", -- Enfocar en un lenguaje específico
					unfocus_language = "F", -- Desenfocar lenguaje
					update = "R", -- Actualizar árbol de sintaxis
					goto_node = "<cr>", -- Ir al nodo seleccionado
					show_help = "?", -- Mostrar ayuda del Playground
				},
			},
		},
		config = function(_, opts)
			-- 🔧 Configurar Treesitter con las opciones definidas
			require("nvim-treesitter.configs").setup(opts)

			-- 📂 Soporte para archivos MDX en Treesitter
			vim.filetype.add({
				extension = {
					mdx = "mdx",
				},
			})
			vim.treesitter.language.register("markdown", "mdx") -- Registrar MDX como Markdown
		end,
	},
}
