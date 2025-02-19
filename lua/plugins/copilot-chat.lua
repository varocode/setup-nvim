-- This file contains the configuration for integrating GitHub Copilot and Copilot Chat plugins in Neovim.

-- Define prompts for Copilot
-- This table contains various prompts that can be used to interact with Copilot.
local prompts = {
	Explain = "Please explain how the following code works.", -- Prompt to explain code
	Review = "Please review the following code and provide suggestions for improvement.", -- Prompt to review code
	Tests = "Please explain how the selected code works, then generate unit tests for it.", -- Prompt to generate unit tests
	Refactor = "Please refactor the following code to improve its clarity and readability.", -- Prompt to refactor code
	FixCode = "Please fix the following code to make it work as intended.", -- Prompt to fix code
	FixError = "Please explain the error in the following text and provide a solution.", -- Prompt to fix errors
	BetterNamings = "Please provide better names for the following variables and functions.", -- Prompt to suggest better names
	Documentation = "Please provide documentation for the following code.", -- Prompt to generate documentation
	JsDocs = "Please provide JsDocs for the following code.", -- Prompt to generate JsDocs
	DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.", -- Prompt to generate GitHub documentation
	CreateAPost = "Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.", -- Prompt to create a social media post
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.", -- Prompt to generate Swagger API docs
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.", -- Prompt to generate Swagger JsDocs
	Summarize = "Please summarize the following text.", -- Prompt to summarize text
	Spelling = "Please correct any grammar and spelling errors in the following text.", -- Prompt to correct spelling and grammar
	Wording = "Please improve the grammar and wording of the following text.", -- Prompt to improve wording
	Concise = "Please rewrite the following text to make it more concise.", -- Prompt to make text concise
}

-- Plugin configuration
-- This table contains the configuration for various plugins used in Neovim.
return {

	-- Copilot Chat plugin configuration
	{
		"CopilotC-Nvim/CopilotChat.nvim", -- Load the Copilot Chat plugin
		opts = {
			prompts = prompts,
			system_prompt = "soy varocode, creador de la comunidad de varocode Programming y los canales de YouTube, Twitch, Kick, Instagram, X, TikTok y mas con el mismo nombre, soy Google Angular developer expert, Microsoft MVP, experto en Typescript, Lead Architect, me encanta la scream architecture, la clean architecture, la hexagonal architecture, y el patrón composition/presentational. también disfruto modularizar el código, usar una buena separation of concerns y mantenerlo bien limpio. quiero que la inteligencia artificial hable con mi estilo: profesional pero cercano, usando expresiones argentinas relajadas, sin signos de exclamación al inicio ni mayúsculas en la primera letra. que explique conceptos técnicos con ejemplos prácticos, estructurando la respuesta cuando sea necesario y metiendo algo de humor sutil. dale que va. Y cuando pongas codigo de respuesta, no agregues las lineas de codigo a las que pertenecen, y cualquier comentario que agregues al código hazlo en español",
			model = "gpt-4o",
			answer_header = "🚀 varocode 🚀  ",
			window = {
				layout = "float",
			},
		},
	},
}

