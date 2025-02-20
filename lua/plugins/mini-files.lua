return {
	"echasnovski/mini.files",
	version = "*",
	lazy = false, -- 🔥 Cargar el plugin al iniciar Neovim
	config = function()
		local mini_files = require("mini.files")

		mini_files.setup({
			-- content = {
			-- 	filter = function(fs_entry)
			-- 		return not vim.startswith(fs_entry.name, ".") -- Ocultar archivos ocultos
			-- 	end,
			-- },
			windows = {
				preview = true,
				width_focus = 40,
				width_nofocus = 20,
				width_preview = 50,
			},
			options = {
				use_as_default_explorer = true,
				permanent_delete = false, -- No eliminar archivos permanentemente, mover a la papelera
			},
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "L",
				go_out = "h",
				go_out_plus = "H",
				reset = "R",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
				move_down = "j",
				move_up = "k",
				rename = "r",
				delete = "d",
				create = "n",
				copy = "yy",
				paste = "p",
			},
		})

		-- 🔥 Ahora sí se carga mini.files sin depender de leader+fm
		vim.keymap.set("n", "<leader>e", function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		end, { noremap = true, silent = true, desc = "Abrir mini.files (Directorio de Archivo Actual)" })
	end,
}
