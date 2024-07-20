return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function ()
          local opts = {
            defaults = {
              path_display = { "smart" },
              dynamic_preview_title = true,
              mappings = {
                n = {
                  ["q"] = "close",
                  ["l"] = "select_default",
                },
              },

              -- configure to use ripgrep
              vimgrep_arguments = {
                "rg",
                "--follow", -- Follow symbolic links
                "--hidden", -- Search for hidden files
                "--no-heading", -- Don't group matches by each file
                "--with-filename", -- Print the file path with the matched lines
                "--line-number", -- Show line numbers
                "--column", -- Show column numbers
                "--smart-case", -- Smart case search

                -- Exclude some patterns from search
                "--glob=!**/.git/*",
                "--glob=!**/.idea/*",
                "--glob=!**/.vscode/*",
                "--glob=!**/build/*",
                "--glob=!**/dist/*",
                "--glob=!**/yarn.lock",
                "--glob=!**/package-lock.json",
              },
            },
            file_ignore_patterns = {
              "lazy-lock.json",
            },
            pickers = {
              find_files = {
                hidden = true,
                -- needed to exclude some files & dirs from general search
                -- when not included or specified in .gitignore
                find_command = {
                  "rg",
                  "--files",
                  "--hidden",
                  "--glob=!**/.git/*",
                  "--glob=!**/.idea/*",
                  "--glob=!**/.vscode/*",
                  "--glob=!**/build/*",
                  "--glob=!**/dist/*",
                  "--glob=!**/yarn.lock",
                  "--glob=!**/package-lock.json",
                },
              },
              oldfiles = {
                initial_mode = "normal",
              },
            },
          }
          require("telescope").setup(opts)
		
					-- Other telescope configuration options
					local builtin = require('telescope.builtin')
					vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
					vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
					vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
					vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
					vim.keymap.set('n', '<leader>fr', builtin.registers, {})
	end,
}
