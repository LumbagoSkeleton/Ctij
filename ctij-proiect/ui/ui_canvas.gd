extends Control

class_name UICanvas

var current_station_menu
var current_inventory_menu

const PLAYER_INVENTORY = preload("res://ui/player_inventory.tscn")
const CHEST_UI = preload("uid://dvv8wbpirtxrv")
const CRAFTING_MENU = preload("uid://dq3dh8gycgurq")

func open_station_menu(menu_template, station:Station = null):
	if current_station_menu == null and current_inventory_menu == null: # dont overlap menus
		if PlayerData.state != PlayerData.State.IN_MENU:
			current_station_menu = menu_template.instantiate()
			add_child(current_station_menu)
			if station is Chest: # assign opened chest to menu
				current_station_menu.set_chest(station)
				current_station_menu.init_slots()
			PlayerData.state = PlayerData.State.IN_MENU

func close_station_menu():
	if current_station_menu != null:
		current_station_menu.queue_free()
		PlayerData.state = PlayerData.State.IDLE

func open_inventory():
	if current_station_menu == null and current_inventory_menu == null: # dont overlap menus
		if PlayerData.state != PlayerData.State.IN_MENU:
			current_inventory_menu = PLAYER_INVENTORY.instantiate()
			add_child(current_inventory_menu)
			PlayerData.state = PlayerData.State.IN_MENU

func close_inventory():
	if current_inventory_menu != null:
		current_inventory_menu.queue_free()
		PlayerData.state = PlayerData.State.IDLE
