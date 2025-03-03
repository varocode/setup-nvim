return {
	{ "nvzone/volt", lazy = true },

	{
		"nvzone/minty",
		lazy = false,
		cmd = { "Shades", "Huefy" },
	},
	{
		"nvzone/menu",
		lazy = false, -- Asegura que se cargue siempre al iniciar Neovim
		config = function()
			local menu = require("menu")

			-- Configurar atajo de teclado para abrir el menú
			vim.keymap.set("n", "<C-t>", function()
				menu.open("default")
			end, { desc = "Abrir menú principal" })

			-- Configurar clic derecho para abrir menú contextual
			vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
				require("menu.utils").delete_old_menus()

				vim.cmd.exec('"normal! \\<RightMouse>"')

				-- Detecta el buffer donde se hizo clic
				local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
				local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

				menu.open(options, { mouse = true })
			end, { desc = "Abrir menú con clic derecho" })
		end,
	},
}
