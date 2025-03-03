local opt = vim.opt
local g = vim.g

-- Líder para atajos
g.mapleader = " "

-- 🐍 Entorno virtual de Python
g.python3_host_prog = "~/.virtualenvs/myenv/bin/python"

-- 🔍 Corrector ortográfico
opt.spell = false -- Habilitar/deshabilitar corrector
opt.spelllang = "es,en" -- Idiomas del corrector (Español e Inglés)

-- 📄 Codificación
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- 🎨 Apariencia
opt.number = true -- Mostrar números de línea
opt.relativenumber = true -- Números relativos para navegación rápida
opt.cursorline = true -- Resalta la línea actual
opt.termguicolors = true -- Habilita colores 24-bit
opt.signcolumn = "yes" -- Siempre muestra la columna de signos
opt.colorcolumn = "80" -- Línea guía en la columna 80
opt.scrolloff = 10 -- Mantiene el cursor con margen en la pantalla
opt.sidescrolloff = 8 -- Margen al hacer scroll horizontal
opt.wrap = true -- No envuelve líneas (útil para programación)
opt.linebreak = true -- No corta palabras al hacer scroll horizontal
opt.showbreak = "↪ " -- Muestra un símbolo cuando una línea es cortada

-- 🖥️ Barra de estado y comandos
opt.showcmd = true -- Muestra comandos en la barra de estado
opt.cmdheight = 1 -- Altura de la línea de comandos
opt.laststatus = 3 -- Barra de estado siempre visible

-- ⏳ Rendimiento
opt.hidden = true -- Permite cambiar de buffer sin guardar
opt.updatetime = 250 -- Reduce el tiempo de espera para autocompletado y LSP
opt.timeoutlen = 300 -- Reduce el tiempo de espera en combinaciones de teclas
opt.ttimeoutlen = 10 -- Reduce el tiempo de espera entre combinaciones de teclas
opt.synmaxcol = 200 -- Evita problemas con archivos grandes al resaltar sintaxis

-- 📝 Indentación y formato
opt.autoindent = true -- Mantiene la indentación al cambiar de línea
opt.smartindent = true -- Indentación automática según el contexto
opt.breakindent = true -- Indentación correcta en líneas largas
opt.expandtab = true -- Convierte tabulaciones en espacios
opt.shiftwidth = 2 -- Cantidad de espacios para la indentación automática
opt.tabstop = 2 -- Número de espacios por cada tabulación
opt.softtabstop = 2 -- Número de espacios que usa <Tab> y <BS>
opt.backspace = { "start", "eol", "indent" } -- Permite borrar indentaciones completas

-- 🔍 Búsqueda y navegación
opt.ignorecase = true -- Ignora mayúsculas en la búsqueda
opt.smartcase = true -- Usa mayúsculas si la búsqueda incluye mayúsculas
opt.incsearch = true -- Muestra coincidencias en tiempo real
opt.hlsearch = false -- No mantiene resaltados después de la búsqueda
opt.path:append({ "**" }) -- Permite buscar archivos en subdirectorios
opt.wildignore:append({ "*/node_modules/*" }) -- Ignora `node_modules`

-- 📂 Manejo de archivos y sesiones
opt.undofile = true -- Habilita undo persistente
opt.backup = false -- No guarda archivos de respaldo
opt.swapfile = false -- Desactiva archivos swap
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" } -- Guarda el estado de buffers y ventanas
opt.backupskip = { "/tmp/*", "/private/tmp/*" } -- No hacer backup en estas rutas

-- 🔄 División de ventanas
opt.splitbelow = true -- Nuevas ventanas se abren abajo
opt.splitright = true -- Nuevas ventanas se abren a la derecha
opt.splitkeep = "cursor" -- Mantiene el cursor en su posición al dividir ventanas

-- 🖱️ Mouse
opt.mouse = "a" -- Habilita el uso del mouse

-- ⚡ Terminal en Neovim
opt.shell = "zsh" -- Usa Zsh como shell en Neovim

-- 📋 Portapapeles (copia y pega con el sistema)
opt.clipboard = "unnamedplus" -- Usa el portapapeles del sistema

-- 🛠️ Mejoras para plugins y LSP
opt.completeopt = { "menuone", "noselect" } -- Autocompletado más fluido
opt.foldmethod = "expr" -- Habilita el folding con Treesitter
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Usa Treesitter para el folding
opt.foldenable = false -- Desactiva folding al abrir archivos

-- 🎭 Subrayado especial en terminal (undercurl)
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- 📝 Agrega asteriscos en comentarios en bloque
opt.formatoptions:append({ "r" })

-- 🎯 Soporte para archivos especiales
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

-- 🔄 Ajuste de la altura de la línea de comandos según versión de Neovim
if vim.fn.has("nvim-0.8") == 1 then
	opt.cmdheight = 0
end

-- 🎨 Fuente para GUI (Neovide, Goneovim, etc.)
opt.guifont = "JetBrainsMono Nerd Font:h12"
