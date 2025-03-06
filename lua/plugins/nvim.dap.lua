-- This file contains the configuration for the nvim-dap plugin in Neovim.

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio", -- Required for nvim-dap-ui
			"rcarriga/nvim-dap-ui",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = { commented = true },
			},
			{
				"jay-babu/mason-nvim-dap.nvim",
				opts = {
					ensure_installed = {
						"python",
						"node2",
						"delve",
						"bash",
						"coreclr",
						"codelldb",
						"js",
						"firefox",
						"php",
						"local-lua-debugger",
					},
					automatic_installation = true,
				},
			},
		},
		keys = {
			{ "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue Execution",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate Debugging",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			-- Adaptadores
			dap.adapters.python = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = { "-m", "debugpy.adapter" },
			}

			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
			}

			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			-- Configuraciones por lenguaje
			dap.configurations = {
				python = {
					{
						type = "python",
						request = "launch",
						name = "Ejecutar archivo Python",
						program = "${file}",
						pythonPath = function()
							return "/usr/bin/python3"
						end,
						console = "integratedTerminal",
						justMyCode = false,
					},
				},
				javascript = {
					{
						type = "node2",
						request = "launch",
						name = "Depurar archivo JS",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						protocol = "inspector",
						console = "integratedTerminal",
					},
				},
				go = {
					{
						type = "delve",
						name = "Depurar (Go)",
						request = "launch",
						program = "${file}",
						dlvToolPath = vim.fn.stdpath("data") .. "/mason/bin/dlv",
					},
				},
				cpp = {
					{
						name = "Depurar (C++)",
						type = "codelldb",
						request = "launch",
						program = function()
							return vim.fn.input("Ruta del ejecutable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
						args = {},
					},
				},
			}

			-- Integración con DAP-UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			-- Símbolos en el gutter
			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapStopped", { text = "➔", texthl = "DapStoppedLine" })
		end,
	},
}
