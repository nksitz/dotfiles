local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local vpn = sbar.add("item", "vpn", {
	position = "right",
	icon = {
		string = "󰅛",
		color = colors.red,
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
	},
	label = { string = "" },
})

local function update_vpn()
	sbar.exec("wg show interfaces 2>/dev/null", function(wg)
		if wg and wg:match("%S") then
			vpn:set({
				icon = { string = "󰦝", color = colors.green },
				label = { string = "WG", color = colors.green },
			})
		else
			sbar.exec("scutil --nc status ProtonVPN 2>/dev/null", function(output)
				if output and output:match("^Connected") then
					vpn:set({
						icon = { string = "󰦝", color = colors.purple },
						label = { string = "VPN", color = colors.purple },
					})
				else
					vpn:set({
						icon = { string = "󰅛", color = colors.red },
						label = { string = "" },
					})
				end
			end)
		end
	end)
end

vpn:subscribe({ "wifi_change", "system_woke" }, function(_)
	update_vpn()
end)

update_vpn()

return vpn
