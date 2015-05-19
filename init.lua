minetest.register_chatcommand("nametag",{
	params = "<New Colour>",
	description = "Alows a player to set a coloured nametag! This can either have a new colour as a param, or it can be used by itself to bring up a formspec.",
	privs = {shout = true},
	func = function(user, param)
		local player = minetest.get_player_by_name(user)
		param = param:lower()
		if param == "" then
			minetest.chat_send_player(user, "Showing formspec...")
			minetest.after(1, function()
				minetest.show_formspec(user, "name-colours",
					"size[8.5,4.5]"..
					"label[0.25,0.5;Please select the colour you want your nametag to be:]"..
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
		elseif param == "green" then
			player:set_nametag_attributes({
				color = {r = 0, g = 255, b = 0}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		elseif param == "blue" then
			player:set_nametag_attributes({
				color = {r = 0, g = 0, b = 255}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		elseif param == "red" then
			player:set_nametag_attributes({
				color = {r = 255, g = 0, b = 0}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		elseif param == "purple" then
			player:set_nametag_attributes({
				color = {r = 200, g = 0, b = 200}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		elseif param == "yellow" then
			player:set_nametag_attributes({
				color = {r = 255, g = 255, b = 0}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		elseif param == "cyan" then
			player:set_nametag_attributes({
				color = {r = 0, g = 255, b = 255}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		elseif param == "white" then
			player:set_nametag_attributes({
				color = {r = 255, g = 255, b = 255}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		elseif param == "orange" then
			player:set_nametag_attributes({
				color = {r = 255, g = 165, b = 0}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		elseif param == "black" then
			player:set_nametag_attributes({
				color = {r = 0, g = 0, b = 0}
			})
			minetest.chat_send_player(user, "Your nametag colour has been set to " ..param)
		else
			minetest.chat_send_player(user, "Incorrect Color! If you don't know what colours are avalible, just use /nametag without an option after it.")
		end
	end
})

minetest.register_chatcommand("nametag-custom", {
	params = "<Red Value> <Green Value> <Blue Value>",
	description = "Change the colour of a nametage to a custom colour (in RGB Format)",
	func = function(user, param)
		local found, _, redValue, greenValue, blueValue = param:find("^([^%s]+)%s+(.+)%s+(.+)$")
		if not found then
			minetest.chat_send_player(user, "Not enough Arguments!")
			return
		end
		local player = minetest.get_player_by_name(user)
		player:set_nametag_attributes({
			color = {r = redValue, g = greenValue, b = blueValue}
		})
		minetest.chat_send_player(user, "Your nametag colour has been set to the RBG value of " ..redValue .. ", " .. greenValue .. ", " .. blueValue)
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "name-colours" then return end
	if fields.green then
		player:set_nametag_attributes({
			color = {r = 0, g = 255, b = 0}
		})
	elseif fields.blue then
		player:set_nametag_attributes({
			color = {r = 0, g = 0, b = 255}
		})
	elseif fields.red then
		player:set_nametag_attributes({
			color = {r = 255, g = 0, b = 0}
		})
	elseif fields.purple then
		player:set_nametag_attributes({
			color = {r = 200, g = 0, b = 200}
		})
	elseif fields.yellow then
		player:set_nametag_attributes({
			color = {r = 255, g = 255, b = 0}
		})
	elseif fields.cyan then
		player:set_nametag_attributes({
			color = {r = 0, g = 255, b = 255}
		})
	elseif fields.white then
		player:set_nametag_attributes({
			color = {r = 255, g = 255, b = 255}
		})
	elseif fields.orange then
		player:set_nametag_attributes({
			color = {r = 255, g = 165, b = 0}
		})
	elseif fields.black then
		player:set_nametag_attributes({
			color = {r = 0, g = 0, b = 0}
		})
	end
end)
