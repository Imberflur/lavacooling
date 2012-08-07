COOLING_RATE = 10
IRON_FORMATION_RATE = 32

--Nodes/Items/Fuels
minetest.register_node("lavacooling:moltenrock", {
	description = "Molten Rock",
	inventory_image = minetest.inventorycube("lavacooling_moltenrock.png"),
	tiles = {
		"lavacooling_moltenrock.png"
	},
	paramtype = "light",
	light_source = 10,
	groups = {cracky=3, hot=3, igniter=1},
})

minetest.register_craft({
	type = "fuel",
	recipe = "lavacooling:moltenrock",
	burntime = 30,
})

minetest.register_craftitem("lavacooling:obsidian_shard", {
	description = "Obsidian Shard",
	inventory_image = "lavacooling_obsidian_shard.png",
})

minetest.register_node("lavacooling:obsidian", {
	description = "Obsidian",
	tiles = {"lavacooling_obsidian.png"},
	groups = {cracky=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"lavacooling:obsidian_shard"},
				rarity = 8,
			},
			{
			items = {"lavacooling:obsidian"},
			rarity = 32,
			},
		}
	},
})

--ABMs
minetest.register_abm ({
	nodenames = {"default:lava_source", "default:lava_flowing"},
	neighbors = {"default:water_source", "default:water_flowing"},
	interval = 1.0,
	chance = 1,
	action = function (pos)
		minetest.env: add_node (pos, {name = "lavacooling:obsidian"})
	end,
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	neighbors = {"default:water_source", "default:water_flowing"},
	interval = 1.0,
	chance = 1,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone"})
	end,
})

minetest.register_abm ({
	nodenames = {"default:lava_source", "default:lava_flowing"},
	neighbors = {"air"},
	interval = 5.0,
	chance = COOLING_RATE*6,
	action = function (pos)
		minetest.env: add_node (pos, {name = "lavacooling:moltenrock"})
	end,
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = 10.0,
	chance = COOLING_RATE*30,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone"})
	end,
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = 10.0,
	chance = COOLING_RATE*IRON_FORMATION_RATE*30,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone_with_iron"})
	end,
})