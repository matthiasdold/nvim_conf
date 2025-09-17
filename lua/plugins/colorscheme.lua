return { -- add moonlfy
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        return {
          TelescopePromptBorder = { bg = "NONE" },
          TelescopeResultsBorder = { bg = "NONE" },
          TelescopePreviewBorder = { bg = "NONE" },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          -- My custom colors
          CursorLineNr = { fg = "#aef202", bg = "none" },
          WinSeparator = { fg = "#747494" },
        }
      end,
      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
    -- add a few custom options to the colorscheme
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}

-- Tryout for an overwrite with a more green based theme
-- return { -- add moonlfy
--   {
--     "rebelot/kanagawa.nvim",
--     opts = {
--       compile = false, -- enable compiling the colorscheme
--       undercurl = true, -- enable undercurls
--       commentStyle = { italic = true },
--       functionStyle = {},
--       keywordStyle = { italic = true },
--       statementStyle = { bold = true },
--       typeStyle = {},
--       transparent = true, -- do not set background color
--       dimInactive = false, -- dim inactive window `:h hl-NormalNC`
--       terminalColors = true, -- define vim.g.terminal_color_{0,17}
--       colors = { -- add/modify theme and palette colors
--         palette = {
--           -- Core Background and Foreground
--           sumiInk0 = "#1c1c1a", -- Darkest background
--           sumiInk1 = "#2a2a28", -- Lighter background for UI
--           fujiWhite = "#dcdccc", -- Primary text
--
--           -- Green Tones (The heart of the theme)
--           waveGreen1 = "#4a6949", -- A deep, muted green
--           waveGreen2 = "#6e8b6e", -- A mid-tone green
--           springGreen = "#8a9a5b", -- A brighter, vibrant green
--
--           -- Accent Colors
--           carpYellow = "#d7a95f", -- Warm yellow for strings, constants
--           sakuraPink = "#d27e99", -- Muted pink for functions
--           waveBlue = "#5a778c", -- Calming blue for types, identifiers
--           katanaGray = "#7a7a7a", -- Neutral gray for comments
--
--           -- Other original Kanagawa colors can be used as fallbacks or for specific UI parts
--           fujiGray = "#727169",
--           oniViolet = "#957FB8",
--           crystalBlue = "#7E9CD8",
--           roninYellow = "#FF9E3B",
--           peachRed = "#FF5D62",
--         },
--         theme = {
--           wave = {},
--           lotus = {},
--           dragon = {},
--           all = {
--             ui = {
--               bg_gutter = "none",
--             },
--           },
--         },
--       },
--       overrides = function(colors) -- add/modify highlights
--         local theme = colors.theme
--         local palette = colors.palette
--         return {
--           TelescopePromptBorder = { bg = "NONE" },
--           TelescopeResultsBorder = { bg = "NONE" },
--           TelescopePreviewBorder = { bg = "NONE" },
--           Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
--           PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
--           PmenuSbar = { bg = theme.ui.bg_m1 },
--           PmenuThumb = { bg = theme.ui.bg_p2 },
--           -- My custom colors
--           CursorLineNr = { fg = "#aef202", bg = "none" },
--           WinSeparator = { fg = "#747494" },
--
--           -- Overrides as suggested by gemini --> for green based theme
--           Normal = { fg = palette.fujiWhite, bg = palette.sumiInk0 },
--           -- Visual = { bg = palette.waveGreen1 },
--           StatusLine = { fg = palette.fujiWhite, bg = palette.sumiInk1 },
--           StatusLineNC = { fg = palette.fujiGray, bg = palette.sumiInk1 },
--           LineNr = { fg = palette.fujiGray },
--           -- CursorLineNr = { fg = palette.fujiWhite },
--           -- Pmenu = { bg = palette.sumiInk1, fg = palette.fujiWhite },
--           -- PmenuSel = { bg = palette.waveGreen1 },
--
--           -- Syntax Highlights
--           Comment = { fg = palette.katanaGray, italic = true },
--           Constant = { fg = palette.carpYellow },
--           String = { fg = palette.carpYellow },
--           Number = { fg = palette.sakuraPink },
--
--           Type = { fg = palette.waveBlue },
--           Identifier = { fg = palette.waveBlue },
--
--           Function = { fg = palette.springGreen },
--           Statement = { fg = palette.sakuraPink },
--           Keyword = { fg = palette.sakuraPink, italic = true },
--           Operator = { fg = palette.fujiWhite },
--           PreProc = { fg = palette.springGreen },
--         }
--       end,
--       theme = "wave", -- Load "wave" theme when 'background' option is not set
--       background = { -- map the value of 'background' option to a theme
--         dark = "wave", -- try "dragon" !
--         light = "lotus",
--       },
--     },
--     -- add a few custom options to the colorscheme
--   },
--
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "kanagawa",
--     },
--   },
-- }
