return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = false,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
          end
        end,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
      end
    end,
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
  {
    "tribela/transparent.nvim",
    event = "VimEnter",
    config = function()
      require("transparent").setup({
        enable = true, -- Enables the transparency
        extra_groups = { -- Makes all groups transparent
          "Normal",
          "NormalNC",
          "VertSplit",
          "StatusLine",
          "StatusLineNC",
          "TabLine",
          "TabLineFill",
          "TabLineSel",
          "EndOfBuffer",
          "BufferLine*",
          "Pmenu",
          "PmenuSel",
          "PmenuSbar",
          "PmenuThumb",
          "CursorLine",
          "CursorColumn",
          "WildMenu",
          "MatchParen",
          "Search",
          "IncSearch",
          "Comment",
          "CursorLineNr",
          "LineNr",
          "SignColumn",
          "Health*",
          "DiffAdd",
          "DiffChange",
          "DiffDelete",
          "DiffText",
          "ErrorMsg",
          "WarningMsg",
          "Question",
          "MoreMsg",
          "SpellBad",
          "SpellCap",
          "SpellLocal",
          "SpellRare",
        },
        exclude_groups = {}, -- You can exclude specific groups from becoming transparent
      })
    end,
  },
}
