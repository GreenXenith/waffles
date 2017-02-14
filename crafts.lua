--+--Crafting Recipes--+--

--Waffle Maker
minetest.register_craft({
	output = 'waffles:wafflemaker',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:furnace', 'default:copper_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

--Reverse Recipe for Waffle Maker
minetest.register_craft({
	output = 'waffles:wafflemaker',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:copper_ingot', 'default:furnace', ''},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

--Waffle Batter
minetest.register_craft({
	output = 'waffles:waffle_batter',
	recipe = {
		{'default:steel_ingot'},
		{'farming:flour'},
		{'bucket:bucket_water'},
	}
})

--Small Waffles
minetest.register_craft({
	output = 'waffles:small_waffle 4',
	recipe = {
		{'waffles:large_waffle'},
	}
})

--Alternate Recipes if Homedecor is Enabled
if minetest.get_modpath("homedecor") then

--Remove Original Recipes
minetest.register_craft({
	output = 'waffles:wafflemaker 0',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:furnace', 'default:copper_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'waffles:wafflemaker 0',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:copper_ingot', 'default:furnace', ''},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})	

--Add New Recipes
minetest.register_craft({
	output = 'waffles:wafflemaker',
	recipe = {
		{'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting'},
		{'', '', 'homedecor:power_crystal'},
		{'homedecor:plastic_sheeting', 'homedecor:heating_element', 'homedecor:copper_strip'},
	}
})

minetest.register_craft({
	output = 'waffles:wafflemaker',
	recipe = {
		{'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting'},
		{'homedecor:power_crystal', '', ''},
		{'homedecor:copper_strip', 'homedecor:heating_element', 'homedecor:plastic_sheeting'},
	}
})	
end
