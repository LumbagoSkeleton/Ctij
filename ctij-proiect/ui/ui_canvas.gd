extends Control

class_name UICanvas

const PLAYER_INVENTORY = preload("res://ui/player_inventory.tscn")

func toggle_inventory(do_open:bool):
	if do_open:
		var inventory = PLAYER_INVENTORY.instantiate()
		add_child(inventory)
	else:
		for inv_instance in get_children():
			if inv_instance is PlayerInventory:
				remove_child(inv_instance)
