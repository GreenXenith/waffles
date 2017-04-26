--Batter registered here because of many lines
minetest.register_tool("waffles:waffle_batter", {
	description = "Waffle Batter",
	inventory_image = "waffle_batter.png",
	wield_image = "waffle_batter.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos)

		if node.name == "waffles:wafflemaker_open_empty" then

			minetest.set_node(pos, {name = "waffles:wafflemaker_open_full", param2 = node.param2})
			return ItemStack("waffles:waffle_batter_two_thirds")
		end

	end,
})

minetest.register_tool("waffles:waffle_batter_two_thirds", {
	description = "Waffle Batter",
	inventory_image = "waffle_batter_two_thirds.png",
	wield_image = "waffle_batter_two_thirds.png",
	stack_max = 1,
	groups = {not_in_creative_inventory = 1},
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos)

		if node.name == "waffles:wafflemaker_open_empty" then

			minetest.set_node(pos, {name = "waffles:wafflemaker_open_full", param2 = node.param2})
			return ItemStack("waffles:waffle_batter_one_third")
		end

	end,
})

local function remove_empty_can(player)
	local inv = player:get_inventory()
	local ret = inv:remove_item("main", ItemStack("waffles:waffle_batter_one_third"))
	local itemstack = inv:get_stack("main", player:get_wield_index())
	local was_success = ret:get_count() == 1
	return itemstack, was_success
end

minetest.register_tool("waffles:waffle_batter_one_third", {
	description = "Waffle Batter",
	inventory_image = "waffle_batter_one_third.png",
	wield_image = "waffle_batter_one_third.png",
	stack_max = 1,
	groups = {not_in_creative_inventory = 1},
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos)

		if node.name == "waffles:wafflemaker_open_empty" then

			minetest.set_node(pos, {name = "waffles:wafflemaker_open_full", param2 = node.param2})
			itemstack, was_success = remove_empty_can(user)
			return itemstack
		end

	end,
})
