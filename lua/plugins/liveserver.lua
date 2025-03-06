return {

	{
		"aurum77/live-server.nvim",
		build = function()
			require("live_server.util").install()
		end,
		cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
		config = function()
			local status_ok, live_server = pcall(require, "live_server")
			if not status_ok then
				return
			end

			live_server.setup({
				port = 7567, -- Cambia el puerto si lo deseas
				browser_command = "firefox", -- Usa el navegador predeterminado
				quiet = false,
				no_css_inject = false, -- Cambiar a true si usas TailwindCSS y no quieres inyección de CSS
				install_path = vim.fn.stdpath("config") .. "/live-server/",
			})
		end,
	},
}
