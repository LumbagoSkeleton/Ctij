extends Control

class_name UICanvas

const PLAYER_INVENTORY = preload("res://ui/player_inventory.tscn")
const CHEST_UI = preload("uid://dvv8wbpirtxrv")
const CRAFTING_MENU = preload("uid://dq3dh8gycgurq")

func open_menu(menu_template):
	if PlayerData.state != PlayerData.State.IN_MENU:
		var menu = menu_template.instantiate()
		add_child(menu)

func close_menus(close_inventory:bool):
	for menu in get_children():
		if (menu is PlayerInventory and close_inventory) or (not close_inventory and menu is not PlayerInventory):
			remove_child(menu)
