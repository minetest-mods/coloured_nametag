local colors = {
	green   = {r = 0,   g = 255, b = 0},
	blue    = {r = 0,   g = 0,   b = 255},
	red     = {r = 255, g = 0,   b = 0},
	purple  = {r = 200, g = 0,   b = 200},
	yellow  = {r = 255, g = 255, b = 0},
	cyan    = {r = 0,   g = 255, b = 255},
	white   = {r = 255, g = 255, b = 255},
	orange  = {r = 255, g = 165, b = 0},
	black   = {r = 0,   g = 0,   b = 0}
}

-- Register command to allow players to colour their nametag
minetest.register_chatcommand("nametag",{
	params = "<color>",
	description = "Allows players to colour their nametag. Type /nametag to see available colors",
	privs = {shout = true},
	func = function(user, param)
		param = param:lower()
		local found, _, redValue, greenValue, blueValue = param:find("^([^%s]+)%s+(.+)%s+(.+)$")
		if param == "" then
			minetest.after(0, minetest.show_formspec, user, "nametag",
				"size[8.5,4.5]"..
				"label[0.25,0.5;Choose a color:]" ..
				"button_exit[0.25,1.5;2.5,0.5;green;Green]" ..
				"button_exit[3,1.5;2.5,0.5;blue;Blue]" ..
				"button_exit[5.75,1.5;2.5,0.5;red;Red]" ..
				"button_exit[0.25,2.5;2.5,0.5;purple;Purple]" ..
				"button_exit[3,2.5;2.5,0.5;yellow;Yellow]" ..
				"button_exit[5.75,2.5;2.5,0.5;cyan;Cyan]" ..
				"button_exit[0.25,3.5;2.5,0.5;white;White]" ..
				"button_exit[3,3.5;2.5,0.5;orange;Orange]" ..
				"button_exit[5.75,3.5;2.5,0.5;black;Black]"
			)
		elseif colors[param] then
			local player = minetest.get_player_by_name(user)
			player:set_nametag_attributes({color = colors[param]})
			player:set_attribute("nametag_color", minetest.serialize(colors[param]))

			return true, "Your nametag color has been set to " .. param:gsub("^%l", string.upper)
		elseif found then
			local player = minetest.get_player_by_name(user)
			local color = {r = redValue, g = greenValue, b = blueValue}
			player:set_nametag_attributes({color = color})
			player:set_attribute("nametag_color", minetest.serialize(color))

			return true, "Your nametag color has been set to the value of: " ..
				redValue .. ", " .. greenValue .. ", " .. blueValue
		else
			return false, "Incorrect Color! If you don't know what colours are avalible, just use /nametag without an option after it."
		end
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "nametag" then
		for key, value in pairs(colors) do
			if fields[key] then
				player:set_nametag_attributes({color = colors[key]})
				player:set_attribute("nametag_color", minetest.serialize(colors[key]))
				minetest.chat_send_player(player:get_player_name(), "Your nametag color has been set to " .. key:gsub("^%l", string.upper))
			end
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	local color = minetest.deserialize(player:get_attribute("nametag_color"))

	if color then
		player:set_nametag_attributes({color = color})
	end
end)

-- Log
if minetest.settings:get_bool("log_mods") then
	minetest.log("action", ("[MOD] Coloured nametag loaded"))
end
