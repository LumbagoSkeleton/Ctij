extends Node

class_name CraftingRecipe

var requires:Array[Item]
var gives:Array[Item]

func craft():
	if player_has_resources():
		for recipe_item in requires:
			for player_item:Item in PlayerData.inventory.items.values():
				if player_item.id == recipe_item.id:
					var grid_pos = PlayerData.inventory.get_grid_pos_of_item(player_item)
					player_item.item_amount -= recipe_item.item_amount
					PlayerData.inventory.update_item(grid_pos, player_item)
					continue
	for given_item in gives:
		for r in range(0, PlayerData.inventory.ROWS-1):
			for c in range(0,PlayerData.inventory.COLUMNS-1):
				var grid_pos = Vector2i(r,c)
				var item_at_grid_pos:Item = PlayerData.inventory.get_item_at_grid_pos(grid_pos)
				if item_at_grid_pos != null:
					PlayerData.inventory.add_item(grid_pos, item_at_grid_pos)
					continue
				elif item_at_grid_pos.id == given_item.id:
					item_at_grid_pos.item_amount += given_item.item_amount
					PlayerData.inventory.update_item(grid_pos, item_at_grid_pos)
					continue

func player_has_resources() -> bool: # checks each item in inventory
	for recipe_item in requires:
		var found = false
		for player_item:Item in PlayerData.inventory.items.values():
			if (player_item.id == recipe_item.id) and (player_item.item_amount >= recipe_item.item_amount):
				found = true
		if not found:
			return false
	return true
