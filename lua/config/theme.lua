-- Light/dark switching, kept in sync with kitty.
--
-- kanagawa already maps 'background' to a variant (wave for dark, lotus for
-- light), so flipping vim.o.background is enough to change the colorscheme.
-- The bits that do NOT follow automatically are plugins with hardcoded colors;
-- those are re-applied in apply_overrides() below.

local M = {}

local state_file = vim.fn.expand("~/.local/state/theme-mode")

-- Bufferline hardcodes hex colors, so it cannot follow the colorscheme on its
-- own. Derive its highlights from the active kanagawa palette instead.
-- Bufferline hardcodes hex colors, so it cannot follow the colorscheme on its
-- own. Set its highlight groups directly: calling bufferline.setup() again does
-- not reliably re-apply them (it caches the highlights from the first setup).
local function apply_overrides()
  local dark = vim.o.background == "dark"
  local c = dark
      and { bg = "#2a2a37", sel = "#3a3a47", edge = "#1f1f28", fg = "#ffffff", dim = "#cacaca" }
      or { bg = "#f2efdf", sel = "#fffbef", edge = "#bec5b2", fg = "#5c6a72", dim = "#829181" }

  local hl = {
    Background = { bg = c.bg },
    CloseButton = { bg = c.bg },
    CloseButtonVisible = { bg = c.bg },
    BufferSelected = { bg = c.sel, fg = c.fg, bold = true },
    BufferVisible = { bg = c.bg },
    CloseButtonSelected = { bg = c.sel },
    Separator = { bg = c.bg, fg = c.edge },
    SeparatorSelected = { bg = c.sel, fg = c.edge },
    OffsetSeparator = { bg = c.sel, fg = c.edge },
    SeparatorVisible = { bg = c.bg, fg = c.edge },
    DuplicateSelected = { bg = c.sel, fg = c.dim },
    DuplicateVisible = { bg = c.bg, fg = c.dim },
    Duplicate = { bg = c.bg, fg = c.dim },
    Fill = { bg = c.edge },
  }
  -- Diagnostic accents keep their hue; only the backgrounds follow the mode.
  for _, spec in ipairs({
    { "Modified", "#98BB66", "#8da101" },
    { "Error", "#C75D6A", "#f85552" },
    { "Warning", "#ffa066", "#dfa000" },
  }) do
    local name, dfg, lfg = spec[1], spec[2], spec[3]
    local fg = dark and dfg or lfg
    hl[name] = { bg = c.bg, fg = fg }
    hl[name .. "Visible"] = { bg = c.bg, fg = fg }
    hl[name .. "Selected"] = { bg = c.sel, fg = fg }
  end

  for name, spec in pairs(hl) do
    pcall(vim.api.nvim_set_hl, 0, "BufferLine" .. name, spec)
  end
end

--- Switch the editor between light and dark.
--- @param mode string|nil "light" or "dark"; toggles when omitted.
function M.set(mode)
  if mode ~= "light" and mode ~= "dark" then
    mode = vim.o.background == "dark" and "light" or "dark"
  end
  if vim.o.background ~= mode then
    vim.o.background = mode
  end
  -- kanagawa's transparent=true leaves the terminal background showing through,
  -- which is what keeps nvim and kitty visually consistent.
  pcall(vim.cmd.colorscheme, "kanagawa")
  apply_overrides()
  return mode
end

--- Toggle both nvim and kitty, by delegating to the shared shell script so the
--- two stay in lockstep no matter which side initiated the change.
function M.toggle_all()
  local mode = vim.o.background == "dark" and "light" or "dark"
  vim.fn.jobstart({ "kitty-theme-toggle", mode }, { detach = true })
  M.set(mode)
  vim.notify("theme: " .. mode)
end

--- Adopt whatever mode the shell script last wrote, so a new nvim started after
--- a toggle comes up in the right mode.
function M.sync_from_state()
  local f = io.open(state_file, "r")
  if not f then
    return
  end
  local mode = vim.trim(f:read("*l") or "")
  f:close()
  if mode == "light" or mode == "dark" then
    M.set(mode)
  end
end

-- A colorscheme load wipes custom highlights, so re-apply the bufferline
-- overrides every time one is applied (including LazyVim's startup one).
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.schedule(apply_overrides)
  end,
})

-- Called by kitty-theme-toggle over --remote-expr.
function _G.SetBackground(mode)
  M.set(mode)
  return 1
end

return M
