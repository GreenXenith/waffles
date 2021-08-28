local waffles = ...

local MODNAME = minetest.get_current_modname()
local S = minetest.get_translator(MODNAME)

-- Waffle
local box_waffle = {
    type = "fixed",
    fixed = {-5 / 16, -8 / 16, -5 / 16, 5 / 16, - 7 / 16, 5 / 16},
}

minetest.register_node(MODNAME .. ":waffle", {
    description = S("Waffle"),
    drawtype = "mesh",
    mesh = "waffles_waffle.obj",
    tiles = {"waffles_waffle.png"},
    inventory_image = "waffles_waffle_inv.png",
    wield_image = "waffles_waffle_inv.png",
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 1},
    selection_box = box_waffle,
    collision_box = box_waffle,
    on_use = minetest.item_eat(8),
    on_place = minetest.rotate_and_place,
})

minetest.register_craftitem(MODNAME .. ":waffle_quarter", {
    description = S("Quarter of Waffle"),
    inventory_image = "waffles_waffle_quarter.png",
    on_use = minetest.item_eat(2)
})

minetest.register_craft({
    output = MODNAME .. ":waffle_quarter 4",
    type = "shapeless",
    recipe = {MODNAME .. ":waffle"},
})

-- Batter
for i = 1, 3 do
    minetest.register_craftitem(MODNAME .. ":waffle_batter_" .. i, {
        description = S("Waffle Batter"),
        inventory_image = "waffles_waffle_batter_" .. i .. ".png",
        stack_max = 1,
        use_texture_alpha = true,
        groups = {not_in_creative_inventory = i == 3 and 0 or 1},
    })
end

local craftitems = {
    ing1 = waffles.get_craftitem("batter_ingredient_1", "farming:flour"),
    ing2 = waffles.get_craftitem("batter_ingredient_2", "farming:flour"),
    water = waffles.get_craftitem("batter_ingredient_water", "bucket:bucket_water"),
}

minetest.register_craft({
	output = MODNAME .. ":waffle_batter_3",
    type = "shapeless",
	recipe = {craftitems.ing1, craftitems.ing2, craftitems.water},
})
