if vim.loader then
	vim.loader.enable()
end

require("config.lazy")

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

