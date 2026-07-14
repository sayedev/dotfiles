--!nonstrict
-- ProtonVPN status indicator for the Noctalia bar.
--
-- Native v5 widgets can't poll a command, so this is the supported way to get a
-- live indicator: a plugin bar widget. It runs vpn-status.sh (deployed to
-- ~/.config/noctalia/scripts/), parses its JSON, and renders the server label, a
-- shield glyph, a theme color and a tooltip. Left-click opens the connection
-- editor.
--
-- vpn-status.sh prints, e.g.:
--   {"text":"AT#48","icon":"shield-check","iconColor":"primary",
--    "textColor":"primary","tooltip":"Server: AT#48\nIP: ..."}

local SCRIPT = noctalia.expandPath("~/.config/noctalia/scripts/vpn-status.sh")
local INTERVAL_MS = 5000
local TIMEOUT_MS = 4000

local function applyColor(role)
  if role == nil or role == "" or role == "none" then
    role = "on_surface"
  end
  barWidget.setColor(role)
  barWidget.setGlyphColor(role)
end

local function apply(data)
  barWidget.setGlyph(data.icon or "shield-off")
  barWidget.setText(data.text or "")
  barWidget.setTooltip(data.tooltip or "")
  applyColor(data.iconColor or data.textColor)
end

local function refresh()
  noctalia.runAsync(SCRIPT, function(res)
    if res == nil or res.exitCode ~= 0 or res.stdout == "" then
      barWidget.setGlyph("shield-off")
      barWidget.setText("VPN")
      barWidget.setTooltip("vpn-status.sh unavailable")
      applyColor("error")
      return
    end
    local data = noctalia.json.decode(res.stdout)
    if type(data) ~= "table" then
      barWidget.setTooltip("VPN: could not parse status output")
      return
    end
    apply(data)
  end, TIMEOUT_MS)
end

-- Paint something immediately so the bar isn't blank before the first tick.
barWidget.setGlyph("shield-off")
barWidget.setText("VPN")
refresh()

function update()
  noctalia.setUpdateInterval(INTERVAL_MS)
  refresh()
end

function onClick()
  noctalia.runAsync("nm-connection-editor")
end
