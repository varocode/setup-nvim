local discipline = require("varocode.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Realizar acciones sin afectar los registros
-- keymap.set("n", "x", '"_x') -- Eliminar un carácter sin guardarlo en el portapapeles
-- keymap.set("n", "<Leader>p", '"0p') -- Pegar desde el registro 0
-- keymap.set("n", "<Leader>P", '"0P') -- Pegar antes desde el registro 0
-- keymap.set("v", "<Leader>p", '"0p') -- Pegar en modo visual desde el registro 0
-- keymap.set("n", "<Leader>c", '"_c') -- Cortar sin guardar en el portapapeles
-- keymap.set("n", "<Leader>C", '"_C') -- Cortar sin guardar en el portapapeles (línea completa)
-- keymap.set("v", "<Leader>c", '"_c') -- Cortar en modo visual sin guardar en el portapapeles
-- keymap.set("v", "<Leader>C", '"_C') -- Cortar en modo visual sin guardar en el portapapeles (línea completa)
-- keymap.set("n", "<Leader>d", '"_d') -- Eliminar sin afectar el portapapeles
-- keymap.set("n", "<Leader>D", '"_D') -- Eliminar línea sin afectar el portapapeles
-- keymap.set("v", "<Leader>d", '"_d') -- Eliminar en modo visual sin afectar el portapapeles
-- keymap.set("v", "<Leader>D", '"_D') -- Eliminar línea en modo visual sin afectar el portapapeles

-- Incrementar / decrementar números
keymap.set("n", "+", "<C-a>") -- Incrementar número bajo el cursor
keymap.set("n", "-", "<C-x>") -- Decrementar número bajo el cursor

-- Eliminar una palabra hacia atrás
keymap.set("n", "dw", 'vb"_d') -- Seleccionar palabra anterior y eliminarla sin afectar el portapapeles

-- Seleccionar todo el archivo
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Guardar con permisos de root (aún no funcional)
-- vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Evitar la continuación automática de comentarios
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts) -- Insertar nueva línea sin mantener el comentario anterior
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts) -- Insertar línea arriba sin continuar el comentario

-- Gestión del historial de saltos (Jump List)
keymap.set("n", "<C-m>", "<C-i>", opts) -- Moverse entre posiciones del historial

-- Gestión de pestañas
keymap.set("n", "te", ":tabedit") -- Abrir una nueva pestaña
keymap.set("n", "<tab>", ":tabnext<Return>", opts) -- Ir a la siguiente pestaña
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts) -- Ir a la pestaña anterior

-- Dividir ventanas
keymap.set("n", "ss", ":split<Return>", opts) -- Dividir horizontalmente
keymap.set("n", "sv", ":vsplit<Return>", opts) -- Dividir verticalmente

-- Moverse entre ventanas divididas
keymap.set("n", "sh", "<C-w>h") -- Moverse a la ventana izquierda
keymap.set("n", "sk", "<C-w>k") -- Moverse a la ventana superior
keymap.set("n", "sj", "<C-w>j") -- Moverse a la ventana inferior
keymap.set("n", "sl", "<C-w>l") -- Moverse a la ventana derecha

-- Ajustar tamaño de ventanas
keymap.set("n", "<C-w><left>", "<C-w><") -- Reducir tamaño de la ventana izquierda
keymap.set("n", "<C-w><right>", "<C-w>>") -- Aumentar tamaño de la ventana derecha
keymap.set("n", "<C-w><up>", "<C-w>+") -- Aumentar altura de la ventana
keymap.set("n", "<C-w><down>", "<C-w>-") -- Reducir altura de la ventana

-- Navegar entre diagnósticos (errores y advertencias)
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

-- Reemplazar colores en formato HEX por HSL
keymap.set("n", "<leader>r", function()
	require("varocode.hsl").replaceHexWithHSL()
end)

-- Alternar sugerencias de LSP (Inlay Hints)
keymap.set("n", "<leader>i", function()
	require("varocode.lsp").toggleInlayHints()
end)

-- 🏃 Salir de cualquier modo con Ctrl + C
vim.keymap.set({ "i", "n", "v", "s", "o", "c", "t" }, "<C-c>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- 📂 Abrir el directorio padre con Oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Abrir directorio padre con Oil" })

-- Bracey

-- Iniciar Bracey
vim.keymap.set("n", "<leader>Bs", ":Bracey<CR>", { desc = "Iniciar Bracey" })

-- Detener Bracey
vim.keymap.set("n", "<leader>Bp", ":BraceyStop<CR>", { desc = "Detener Bracey" })

-- Recargar la página actual
vim.keymap.set("n", "<leader>Br", ":BraceyReload<CR>", { desc = "Recargar Bracey" })

-- Evaluar el buffer actual en el navegador
vim.keymap.set("n", "<leader>Bt", ":BraceyEval<CR>", { desc = "Evaluar con Bracey" })

-- 📌 Asignar Ctrl + S para guardar en modo normal
vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR>", { noremap = true, silent = true })

-- 📌 Asignar Ctrl + S para guardar en modo insert y visual
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:lua SaveFile()<CR>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:lua SaveFile()<CR>gv", { noremap = true, silent = true })

-- 💾 Función personalizada para guardar archivos
function SaveFile()
	-- 🔍 Verificar si hay un archivo abierto en el buffer actual
	if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
		vim.notify("⚠️ No hay archivo para guardar", vim.log.levels.WARN)
		return
	end

	-- 📂 Obtener solo el nombre del archivo sin la ruta
	local filename = vim.fn.expand("%:t")

	-- 💾 Intentar guardar el archivo sin mostrar mensajes en la línea de comandos
	local success, err = pcall(function()
		vim.cmd("silent! write")
	end)

	-- ✅ Si el guardado fue exitoso, mostrar notificación
	if success then
		vim.notify("💾 Archivo guardado: " .. filename, vim.log.levels.INFO)
	else
		-- ❌ Si hubo un error, mostrar mensaje de error
		vim.notify("❌ Error al guardar: " .. err, vim.log.levels.ERROR)
	end
end
