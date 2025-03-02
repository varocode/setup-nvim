return {
	{
		"justinhj/battery.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		config = function()
			require("battery").setup({
				update_rate_seconds = 10, -- Se actualiza cada 30 segundos
				show_percent = true, -- Muestra el porcentaje de batería
				show_status_when_no_battery = true, -- Oculta el icono si no hay batería
				show_plugged_icon = true, -- Muestra un icono si está cargando
				show_unplugged_icon = true, -- Muestra un icono si está desconectado
				vertical_icons = false, -- Usa iconos en línea en lugar de verticales
				multiple_battery_selection = "max", -- Usa la batería con mayor carga en laptops con varias baterías
			})
		end,
	},
}
