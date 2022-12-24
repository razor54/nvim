local PACKER_PATH = vim.fn.stdpath("cache") .. "/packer/packer_compiled.lua"
local float_border = require("jmp.ui").border

local function cfg(name)
	return string.format([[require 'jmp.plugins.cfg.%s']], name)
end

local plugins = {
	--------------------------------------------------
	-- Plugin management and support
	--------------------------------------------------
	"wbthomason/packer.nvim",

	"lewis6991/impatient.nvim",

	"nvim-lua/plenary.nvim",

	{ "dstein64/vim-startuptime", cmd = "StartupTime" },

	--------------------------------------------------
	-- color scheme
	--------------------------------------------------
	"/home/m/files/nonwork/still-light.nvim",

	--------------------------------------------------
	-- LSP
	--------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		config = cfg("lspconfig"),
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "→",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	config = function()
	-- 		require("fidget").setup({
	-- 			align = { bottom = false, },
	-- 			text = { spinner = { "", "", "", "" } },
	-- 			timer = {
	-- 				fidget_decay = 250, -- how long to keep around empty fidget, in ms
	-- 				spinner_rate = 150,
	-- 				task_decay = 250,
	-- 			},
	-- 			window = {
	-- 				relative = "editor",
	-- 				blend = 0,
	-- 			},
	-- 		})
	--
	-- 		vim.api.nvim_set_hl(0, "FidgetTask", { link = "NonText" })
	-- 		vim.api.nvim_set_hl(0, "FidgetTitle", { link = "Statement" })
	-- 	end,
	-- },

	--------------------------------------------------
	-- treesitter
	--------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		config = cfg("treesitter"),
		run = ":TSUpdate",
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		requires = "nvim-treesitter/nvim-treesitter",
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		requires = "nvim-treesitter/nvim-treesitter",
	},

	{
		"danymat/neogen",
		config = cfg("neogen"),
		requires = "nvim-treesitter/nvim-treesitter",
	},

	--------------------------------------------------
	-- editing support
	--------------------------------------------------
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"monaqa/dial.nvim",
		config = cfg("dial"),
	},

	{
		"lewis6991/gitsigns.nvim",
		config = cfg("gitsigns"),
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				close_triple_quotes = true,
				check_ts = false,
				enable_check_bracket_line = true,
			})
		end
	},

	{
		"hrsh7th/nvim-cmp",
		config = cfg("cmp"),
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",

			{
				"petertriho/cmp-git",
				config = function()
					require("cmp_git").setup()
				end,
				requires = "nvim-lua/plenary.nvim",
			},

			"kdheepak/cmp-latex-symbols",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},

	{
		"gbprod/substitute.nvim",
		config = function()
			require("substitute").setup()

			vim.keymap.set("n", "r", require("substitute").operator, {})
			vim.keymap.set("n", "rr", require("substitute").line, {})
			vim.keymap.set("n", "R", require("substitute").eol, {})
			vim.keymap.set("x", "r", require("substitute").visual, {})
		end,
	},

	{
		"machakann/vim-swap",
		config = function()
			vim.keymap.set("n", "<left>", "<Plug>(swap-prev)", {})
			vim.keymap.set("n", "<right>", "<Plug>(swap-next)", {})
		end
	},
	--------------------------------------------------
	-- formatting and linting
	--------------------------------------------------
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = cfg("null_ls"),
	},

	{
		"mcauley-penney/tidy.nvim",
		config = function()
			require("tidy").setup()
		end,
	},

	--------------------------------------------------
	-- motions and textobjects
	--------------------------------------------------
	"michaeljsmith/vim-indent-object",

	{
		"chaoren/vim-wordmotion",
		setup = function()
			vim.g.wordmotion_mappings = { e = "k", ge = "gk" }
		end
	},

	"wellle/targets.vim",

	--------------------------------------------------
	-- navigation and searching
	--------------------------------------------------
	{
		'nvim-telescope/telescope.nvim',

		tag = '0.1.0',
		requires = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
		},
		config = function()
			local builtin = require('telescope.builtin')

			require('telescope').setup({
				defaults = {
					border = false,
					layout_strategy = "bottom_pane",
					layout_config = {
						prompt_position = "top",
						height = 0.25,
						width = 1,
					},
					sorting_strategy = "ascending"
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					}
				}
			})

			require('telescope').load_extension('fzf')

			vim.keymap.set("n", "<C-t>", builtin.find_files, { silent = true })
			vim.keymap.set("n", "\\", builtin.buffers, { silent = true })
		end,
	},

	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({
				case_insensitive = false,
				keys = "arstneioqwfpluy;",
				teasing = false,
			})

			vim.keymap.set("n", "'", "<cmd>HopChar1MW<cr>", { silent = true })
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				auto_close = true,
				auto_preview = false,
				autofold_depth = 2,
				auto_unfold_hover = false,
				highlight_hovered_item = false,
				show_guides = true,
				show_symbol_details = false,
			})

			vim.keymap.set("n", "<F6>", "<cmd>SymbolsOutline<cr>", { silent = true })
		end,
	},

	{
		"simnalamburt/vim-mundo",
		setup = function()
			vim.g.mundo_header = 0
			vim.g.mundo_preview_bottom = 1
			vim.g.mundo_right = 1
			vim.g.mundo_mappings = {
				["<cr>"] = "preview",
				e = "mode_newer",
				n = "mode_older",
				q = "quit",
				["<esc>"] = "quit",
			}

			vim.keymap.set("n", "<leader>u", "<cmd>MundoToggle<cr>", {})
		end,
		cmd = "MundoToggle",
	},

	{
		"airblade/vim-rooter",
		setup = function()
			vim.g.rooter_silent_chdir = 1
		end,
	},

	--------------------------------------------------
	-- UI
	--------------------------------------------------
	{
		"akinsho/bufferline.nvim",
		config = cfg("bufferline"),
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				char = "├",
				filetype_exclude = { "fzf", "mason", "packer" },
				max_indent_increase = 1,
				show_first_indent_level = false,
				show_trailing_blankline_indent = false,
			})
		end
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = {
					"css",
					lua = { names = false },
					text = { names = false },
				}
			})
		end,
	},

	"nvim-tree/nvim-web-devicons",

	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				direction = "horizontal",
				size = 50,
				open_mapping = [[<C-space>]],
			})
		end,
	},

	{
		"itchyny/vim-highlighturl",
		config = function()
			local hl_utils = require("jmp.ui.utils")
			vim.g.highlighturl_guifg = hl_utils.get_hl_grp_rgb("@text.uri", "fg")
		end
	},

	{
		"rrethy/vim-illuminate",
		config = function()
			require('illuminate').configure({
				delay = 150,
				under_cursor = false,
			})

			for _, type in ipairs({ "Text", "Read", "Write" }) do
				vim.api.nvim_set_hl(0, "IlluminatedWord" .. type, { link = "CursorLine" })
			end
		end
	},

	{
		"lukas-reineke/virt-column.nvim",
		config = function()
			require("virt-column").setup({ char = "│" })

			vim.api.nvim_set_hl(0, "VirtColumn", { link = "VertSplit" })
		end,
	},

	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({
				ring = {
					history_length = 0,
					storage = "memory",
					sync_with_numbered_registers = false,
				},
				system_clipboard = {
					sync_with_ring = false,
				},
				highlight = {
					on_put = true,
					on_yank = false,
					timer = 200,
				},
				preserve_cursor_position = {
					enabled = true,
				},
			})

			vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", {})
			vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", {})
			vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", {})
			vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", {})
			vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", {})
		end,
	},

	--------------------------------------------------
	-- filetype support
	--------------------------------------------------
	-- git commit
	"rhysd/committia.vim",

	{
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		setup = function()
			local g = vim.g
			g.mkdp_auto_start = 0
			g.mkdp_auto_close = 0
			g.mkdp_browser = "firefox"
			g.mkdp_page_title = "${name}.md"
			g.mkdp_preview_options = {
				disable_sync_scroll = 0,
				disable_filename = 1,
			}
			g.mkdp_theme = "dark"
		end,
		ft = "markdown",
	},


	{
		"nvim-orgmode/orgmode",
		config = cfg("org"),
	},

	{
		"akinsho/org-bullets.nvim",
		config = cfg("org-bullets"),
		requires = "nvim-orgmode/orgmode"
	},

	--------------------------------------------------
	-- whimsy
	--------------------------------------------------
	{
		"/home/m/files/nonwork/duck.nvim",
		config = function()
			require("duck").setup({
				character = "👹",
				speed = 10,
				wait_mins = 3,
			})
		end
	},

	--------------------------------------------------
	-- testing
	--------------------------------------------------
	{
		"rareitems/hl_match_area.nvim",
		config = function()
			require("hl_match_area").setup({
				delay = 150,
				highlight_in_insert_mode = false
			})
		end
	},

	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({
				review_empty_name = true
			})

			vim.keymap.set("n", "<leader>r", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { expr = true })
		end,
	}
}

require("packer").startup({
	function(use)
		for _, plugin in ipairs(plugins) do
			use(plugin)
		end
	end,

	config = {
		compile_path = PACKER_PATH,
		display = {
			header_sym = "",
			open_fn = function()
				return require("packer.util").float({ border = float_border })
			end,
			prompt_border = float_border,
		},
	},
})

--load plugins from chosen location
if not vim.g.packer_compiled_loaded then
	vim.cmd.source(PACKER_PATH)
	vim.g.packer_compiled_loaded = true
end

return plugins
