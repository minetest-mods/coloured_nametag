local colors = {
    green = {r = 0, g = 255, b = 0},
    blue = {r = 0, g = 0, b = 255},
    red = {r = 255, g = 0, b = 0},
    purple = {r = 200, g = 0, b = 200},
    yellow = {r = 255, g = 255, b = 0},
    cyan = {r = 0, g = 255, b = 255},
    white = {r = 255, g = 255, b = 255},
    orange = {r = 255, g = 165, b = 0},
    black = {r = 0, g = 0, b = 0},
}

-- Register privilege to allow players to colour their nametag
minetest.register_privilege("nametag", {
	description = "Allows you to colour your nametag",
	give_to_singleplayer = false,
})

-- Register command to allow players to colour their nametag
minetest.register_chatcommand("nametag",{
	params = "<color>",
	description = "Allows players to colour their nametag. Type /nametag to see available colors",
	privs = {nametag = true},
	func = function(user, param)
		local player = minetest.get_player_by_name(user)
		param = param:lower()
		if param == "" then
			minetest.after(1, function()
				minetest.show_formspec(user, "name-colours",
					"size[8.5,4.5]"..
					"label[0.25,0.5;Choose a color:]"..
					"button_exit[0.25,1.5;2.5,0.5;green;Green]"..
					"button_exit[3,1.5;2.5,0.5;blue;Blue]"..
					"button_exit[5.75,1.5;2.5,0.5;red;Red]"..
					"button_exit[0.25,2.5;2.5,0.5;purple;Purple]"..
					"button_exit[3,2.5;2.5,0.5;yellow;Yellow]"..
					"button_exit[5.75,2.5;2.5,0.5;cyan;Cyan]"..
					"button_exit[0.25,3.5;2.5,0.5;white;White]"..
					"button_exit[3,3.5;2.5,0.5;orange;Orange]"..
					"button_exit[5.75,3.5;2.5,0.5;black;Black]"
				)
			end)
		elseif colors[param] then
			player:set_nametag_attributes({
			color = colors[param]
		})

minetest.chat_send_player(user, "Your nametag color has been set to: " .. param)
	else
		minetest.chat_send_player(user, "Invalid usage, see /help nametag")
	end
end
})

-- Customized RGB-format color
minetest.register_chatcommand("custom-nametag", {
	params = "<red> <green> <blue>",
	description = "Customizable-nametag color",
	privs = {nametag = true},
	func = function(user, param)
		local found, _, redValue, greenValue, blueValue = param:find("^([^%s]+)%s+(.+)%s+(.+)$")
		if not found then
			minetest.chat_send_player(user, "Invalid usage, see /help custom-nametag")
			return
		end
		local player = minetest.get_player_by_name(user)
		player:set_nametag_attributes({
			color = {r = redValue, g = greenValue, b = blueValue}
		})
		minetest.chat_send_player(user, "Your nametag color has been set to the value of: " ..redValue .. ", " .. greenValue .. ", " .. blueValue)
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "name-colours" then return end
		for key, value in pairs(colors) do
			if fields[key] then
				player:set_nametag_attributes({
            		color = colors[key]
				})
		end
   	end
end)

-- Log
if minetest.settings:get_bool("log_mods") then
	minetest.log("action", ("[MOD] Coloured nametag loaded"))
end
