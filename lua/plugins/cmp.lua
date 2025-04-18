return {
  -- 'iguanacucumber/magazine.nvim',
  -- event = { 'CmdlineEnter', 'InsertEnter' },
  -- dependencies = {
  --   "hrsh7th/cmp-buffer",
  --   "hrsh7th/cmp-cmdline",
  --   "hrsh7th/cmp-emoji",
  --   "kdheepak/cmp-latex-symbols",
  --   "hrsh7th/cmp-nvim-lsp",
  --   "hrsh7th/cmp-nvim-lua",
  --   "hrsh7th/cmp-path",
  --   "L3MON4D3/LuaSnip",
  --   "saadparwaiz1/cmp_luasnip",
  --   "windwp/nvim-autopairs",
  -- },
  -- config = function()
  --   local cmp = require("cmp")
  --   local compare = cmp.config.compare
  --   local pad_len = 1
  --
  --   --[[
  --         Get completion context, such as namespace where item is from.
  --         Depending on the LSP, this information is stored in different places.
  --         The process to find them is very manual: log the payloads And see where useful information is stored.
  --
  --         See https://www.reddit.com/r/neovim/comments/128ndxk/comment/jen9444/?utm_source=share&utm_medium=web2x&context=3
  --     ]]
  --   local function get_lsp_completion_context(completion, source)
  --     local ok, source_name = pcall(function()
  --       return source.source.client.config.name
  --     end)
  --
  --     if not ok then
  --       return nil
  --     end
  --
  --     if source_name == "ts_ls" then
  --       return completion.detail
  --     elseif source_name == "pyright" and completion.labelDetails ~= nil then
  --       return completion.labelDetails.description
  --     elseif source_name == "texlab" then
  --       return completion.detail
  --     elseif source_name == "clangd" then
  --       local doc = completion.documentation
  --       if doc == nil then return end
  --
  --       local import_str = doc.value
  --
  --       local i, j = string.find(import_str, "[\"<].*[\">]")
  --       if i == nil then return end
  --
  --       return string.sub(import_str, i, j)
  --     end
  --
  --     return nil
  --   end
  --
  --   cmp.setup({
  --     formatting = {
  --       fields = { "kind", "abbr", "menu" },
  --       format = function(entry, vim_item)
  --         if not require("cmp.utils.api").is_cmdline_mode() then
  --           local abbr_width_max = 25
  --           local menu_width_max = 20
  --
  --           local choice = require("lspkind").cmp_format({
  --             ellipsis_char = tools.ui.icons.ellipses,
  --             maxwidth = abbr_width_max + menu_width_max,
  --             mode = "symbol",
  --           })(entry, vim_item)
  --
  --           choice.abbr = vim.trim(choice.abbr)
  --
  --           local cmp_ctx = get_lsp_completion_context(entry.completion_item, entry.source)
  --           if cmp_ctx ~= nil and cmp_ctx ~= "" then
  --             choice.menu = cmp_ctx
  --             local menu_width = string.len(choice.menu)
  --
  --             if menu_width > menu_width_max then
  --               choice.menu = vim.fn.strcharpart(choice.menu, 0, menu_width_max - 1)
  --               choice.menu = choice.menu .. tools.ui.icons.ellipses
  --             else
  --               local padding = string.rep(' ', menu_width_max - menu_width)
  --               choice.menu = padding .. choice.menu
  --             end
  --           else
  --             choice.menu = ""
  --             abbr_width_max = abbr_width_max + (menu_width_max / 2)
  --           end
  --
  --           -- give padding until min/max width is met
  --           -- https://github.com/hrsh7th/nvim-cmp/issues/980#issuecomment-1121773499
  --           local abbr_width = string.len(choice.abbr)
  --           if abbr_width < abbr_width_max then
  --             local padding = string.rep(' ', abbr_width_max - abbr_width)
  --             vim_item.abbr = choice.abbr .. padding
  --           end
  --
  --           return choice
  --         else
  --           local abbr_width_min = 12
  --           local abbr_width_max = 50
  --
  --           local choice = require("lspkind").cmp_format({
  --             ellipsis_char = tools.ui.icons.ellipses,
  --             maxwidth = abbr_width_max,
  --             mode = "symbol",
  --           })(entry, vim_item)
  --
  --           choice.abbr = vim.trim(choice.abbr)
  --
  --           -- give padding until min/max width is met
  --           -- https://github.com/hrsh7th/nvim-cmp/issues/980#issuecomment-1121773499
  --           local abbr_width = string.len(choice.abbr)
  --           if abbr_width < abbr_width_min then
  --             local padding = string.rep(' ', abbr_width_min - abbr_width)
  --             vim_item.abbr = choice.abbr .. padding
  --           end
  --
  --           return choice
  --         end
  --       end,
  --     },
  --     mapping = {
  --       ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  --       ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  --       ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  --       ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  --       ['<C-d>'] = cmp.mapping.scroll_docs(4),
  --     },
  --     matching = {
  --       disallow_fuzzy_matching = false,
  --       disallow_fullfuzzy_matching = false,
  --       disallow_partial_fuzzy_matching = false,
  --       disallow_partial_matching = false,
  --       disallow_prefix_unmatching = false,
  --     },
  --     snippet = {
  --       expand = function(args)
  --         require("luasnip").lsp_expand(args.body)
  --       end,
  --     },
  --     -- source: https://github.com/gennaro-tedesco/dotfiles/blob/4a175cce9f8f445543ac61cc6c4d6a95d6a6da10/nvim/lua/plugins/cmp.lua#L79-L88
  --     -- needs testing
  --     sorting = {
  --       comparators = {
  --         compare.score,
  --         compare.offset,
  --         compare.recently_used,
  --         compare.order,
  --         compare.exact,
  --         compare.kind,
  --         compare.locality,
  --         compare.length,
  --         -- copied from TJ Devries; cmp-under
  --         function(entry1, entry2)
  --           local _, entry1_under = entry1.completion_item.label:find "^_+"
  --           local _, entry2_under = entry2.completion_item.label:find "^_+"
  --           entry1_under = entry1_under or 0
  --           entry2_under = entry2_under or 0
  --           if entry1_under > entry2_under then
  --             return false
  --           elseif entry1_under < entry2_under then
  --             return true
  --           end
  --         end,
  --       },
  --     },
  --     sources = {
  --       { name = "luasnip" },
  --       { name = "nvim_lsp", max_item_count = 20 },
  --       { name = "nvim_lua", max_item_count = 20 },
  --       { name = "buffer",   max_item_count = 5 },
  --       { name = 'orgmode' },
  --       { name = "path" },
  --       { name = 'emoji' },
  --       { name = "git" },
  --       {
  --         name = "latex_symbols",
  --         max_item_count = 10,
  --         option = {
  --           strategy = 0, -- mixed
  --         },
  --       },
  --     },
  --     view = {
  --       entries = {
  --         follow_cursor = true,
  --       }
  --     },
  --     window = {
  --       completion = {
  --         border = tools.ui.borders.none,
  --         col_offset = 1,
  --         scrolloff = 10,
  --         side_padding = pad_len,
  --       },
  --       documentation = {
  --         border = tools.ui.borders.cur_border,
  --       }
  --     }
  --   })
  --
  --   cmp.setup.cmdline(':', {
  --     mapping = {
  --       ["<Tab>"] = {
  --         c = cmp.mapping.confirm({ select = true })
  --       },
  --       ['<C-n>'] = {
  --         c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --       },
  --       ['<C-p>'] = {
  --         c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
  --       }
  --     },
  --     sources = cmp.config.sources({
  --       {
  --         name = 'cmdline',
  --         option = {
  --           treat_trailing_slash = false
  --         }
  --       },
  --       { name = 'path', max_item_count = 20, },
  --     }),
  --   })
  --
  --   -- Use autopairs for adding parenthesis to function completions
  --   local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  --
  --   cmp.event:on(
  --     'confirm_done',
  --     cmp_autopairs.on_confirm_done()
  --   )
  -- end,
}
