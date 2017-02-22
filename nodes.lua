local function get_item(player)
	local inv = player:get_inventory()
	inv:add_item("main", "waffles:large_waffle")
end
local function replace_emptymodel(pos, node)
	minetest.set_node(pos, {name = "waffles:wafflemaker_open_empty", param2 = node.param2})
end

minetest.register_node("waffles:wafflemaker", {
	description = "Waffle Maker",
	drawtype = "mesh",
	mesh = "wafflemaker.obj",
	tiles = {"wafflemaker_texture.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy = 3},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "waffles:wafflemaker_open_empty", param2 = node.param2})
	end
})

minetest.register_node("waffles:wafflemaker_open_empty", {
	description = "Open Waffle Maker (empty)",
	drawtype = "mesh",
	mesh = "wafflemaker_open_empty.obj",
	tiles = {"wafflemaker_open_empty_texture.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy = 3, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	drop = 'waffles:wafflemaker',
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "waffles:wafflemaker", param2 = node.param2})
	end
})

minetest.register_node("waffles:wafflemaker_open_full", {
	description = "Open Waffle Maker (full)",
	drawtype = "mesh",
	mesh = "wafflemaker_open_full.obj",
	tiles = {"wafflemaker_open_full_texture.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, { name = "waffles:wafflemaker_closed_full", param2 = node.param2 })
		minetest.after(5, minetest.set_node, pos, { name = "waffles:wafflemaker_open_done", param2 = node.param2 })
	end,
})

local function replace_donemodel(pos, node)
	minetest.set_node(pos, {name = "waffles:wafflemaker_open_done", param2 = node.param2})
end

minetest.register_node("waffles:wafflemaker_closed_full", {
	description = "Closed Waffle Maker (full)",
	drawtype = "mesh",
	mesh = "wafflemaker_closed_full.obj",
	tiles = {"wafflemaker_texture.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	diggable = false,
	groups = {not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
})

minetest.register_node("waffles:wafflemaker_open_done", {
	description = "Open Waffle Maker (done)",
	drawtype = "mesh",
	mesh = "wafflemaker_open_done.obj",
	tiles = {"wafflemaker_open_done_texture.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	on_punch = function (pos, node, player, pointed_thing)
		get_item(player)
		replace_emptymodel(pos, node)
	end
})

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
			itemstack:add_wear(21900)
			return itemstack
		end

	end,
})

minetest.register_craftitem("waffles:large_waffle", {
	description = "Large Waffle",
	inventory_image = "large_waffle.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craftitem("waffles:small_waffle", {
	description = "Small Waffle",
	inventory_image = "small_waffle.png",
	on_use = minetest.item_eat(2),
})
