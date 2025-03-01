return {
	"smoka7/hop.nvim",
	event = { "BufReadPost", "BufNewFile" }, -- Se carga cuando abres un archivo
	lazy = true, -- Se asegura que no cargue en el arranque
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
}
