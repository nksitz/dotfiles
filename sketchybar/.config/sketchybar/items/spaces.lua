local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}
local space_brackets = {}

sbar.add("event", "aerospace_workspace_change")

local workspace_list = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

for idx, sid in ipairs(workspace_list) do
  local space = sbar.add("item", "space." .. sid, {
    drawing = false,
    icon = {
      font = { family = settings.font.numbers },
      string = sid,
      padding_left = 15,
      padding_right = 8,
      color = colors.white,
      highlight_color = colors.red,
    },
    label = {
      padding_right = 20,
      color = colors.grey,
      highlight_color = colors.white,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.bg1,
      border_width = 1,
      height = 26,
      border_color = colors.black,
    },
    popup = { background = { border_width = 5, border_color = colors.black } }
  })

  spaces[sid] = space

  local space_bracket = sbar.add("bracket", { space.name }, {
    background = {
      color = colors.transparent,
      border_color = colors.bg2,
      height = 28,
      border_width = 2
    }
  })

  space_brackets[sid] = space_bracket

  space:subscribe("aerospace_workspace_change", function(env)
    local focused = env.FOCUSED_WORKSPACE
    local selected = focused == sid
    space:set({
      icon = { highlight = selected },
      label = { highlight = selected },
      background = { border_color = selected and colors.black or colors.bg2 }
    })
    space_bracket:set({
      background = { border_color = selected and colors.grey or colors.bg2 }
    })
  end)

  space:subscribe("mouse.clicked", function(env)
    sbar.exec("aerospace workspace " .. sid)
  end)
end

-- Function to refresh which workspaces are visible and their app icons
local function refresh_workspaces()
  sbar.exec("aerospace list-workspaces --focused", function(focused_ws)
    focused_ws = focused_ws:match("^%s*(.-)%s*$") -- trim whitespace

    for _, sid in ipairs(workspace_list) do
      sbar.exec("aerospace list-windows --workspace " .. sid .. " --format '%{app-name}'", function(result)
        local icon_line = ""
        local has_apps = false

        for app in result:gmatch("[^\r\n]+") do
          local trimmed = app:match("^%s*(.-)%s*$")
          if trimmed and trimmed ~= "" then
            has_apps = true
            local lookup = app_icons[trimmed]
            local icon = ((lookup == nil) and app_icons["Default"] or lookup)
            icon_line = icon_line .. icon
          end
        end

        local is_focused = (focused_ws == sid)
        local should_draw = has_apps or is_focused

        if spaces[sid] then
          spaces[sid]:set({
            drawing = should_draw,
            label = has_apps and icon_line or " —",
            icon = { highlight = is_focused },
            background = { border_color = is_focused and colors.black or colors.bg2 }
          })
        end
        if space_brackets[sid] then
          space_brackets[sid]:set({
            background = { border_color = is_focused and colors.grey or colors.bg2 }
          })
        end
      end)
    end
  end)
end

-- Refresh on workspace change
local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

space_window_observer:subscribe("aerospace_workspace_change", function(env)
  refresh_workspaces()
end)

-- Also refresh on front_app_switched to catch window open/close
space_window_observer:subscribe("front_app_switched", function(env)
  refresh_workspaces()
end)

-- Initial refresh
refresh_workspaces()

local spaces_indicator = sbar.add("item", {
  padding_left = -3,
  padding_right = 0,
  icon = {
    padding_left = 8,
    padding_right = 9,
    color = colors.grey,
    string = icons.switch.on,
  },
  label = {
    width = 0,
    padding_left = 0,
    padding_right = 8,
    string = "Spaces",
    color = colors.bg1,
  },
  background = {
    color = colors.with_alpha(colors.grey, 0.0),
    border_color = colors.with_alpha(colors.bg1, 0.0),
  }
})

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = spaces_indicator:query().icon.value == icons.switch.on
  spaces_indicator:set({
    icon = currently_on and icons.switch.off or icons.switch.on
  })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 1.0 },
        border_color = { alpha = 1.0 },
      },
      icon = { color = colors.bg1 },
      label = { width = "dynamic" }
    })
  end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 0.0 },
        border_color = { alpha = 0.0 },
      },
      icon = { color = colors.grey },
      label = { width = 0 }
    })
  end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)
