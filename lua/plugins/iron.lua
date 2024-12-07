return { -- add moonlfy
  {
    "hkupty/iron.nvim",
    config = function()
      require("iron.core").setup({
        config = {
          -- If iron should expose `<plug>(...)` mappings for the plugins
          should_map_plug = false,
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            -- python = require("iron.fts.python").ipython,
            python = {
              command = { "ipython", "--no-autoindent" },
              format = require("iron.fts.common").bracketed_paste_python,
            },
            sh = {
              command = { "fish" },
            },
          },
          preferred = {
            python = "ipython",
          },
          repl_open_cmd = require("iron.view").split.vertical.botright("40%"),
          buflist = true,
        },
        -- Iron doesn't set keymaps by default anymore. Set them here
        -- or use `should_map_plug = true` and map from you vim files
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>s",
          send_file = "<space>ra",
          send_line = "<space>s",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = false,
        },
      })
    end,
  },
}
