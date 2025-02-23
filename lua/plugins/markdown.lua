return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		heading = {
			enabled = true,
			sign = true,
			style = "full",
			icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
			left_pad = 1,
		},
		bullet = {
			enabled = true,
			icons = { "●", "○", "◆", "◇" },
			right_pad = 1,
			highlight = "render-markdownBullet",
		},
		image = {
			enabled = true, -- Habilita el soporte para imágenes
			max_width = 100, -- Ajusta el ancho máximo de las imágenes
			extensions = { "png", "jpg", "jpeg", "gif" }, -- Tipos de imagen soportados
		},
	},
}
