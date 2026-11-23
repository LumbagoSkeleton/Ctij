extends Control

class_name ChestUI

const INVENTORY_SLOT = preload("res://ui/inventory_slot.tscn")
const INVENTORY_ITEM = preload("res://ui/inventory_item.tscn")

const ROWS = 4
const COLUMNS = 6

@onready var inventory_item_grid_container: GridContainer = $BG/HBoxContainer/InventoryUIContainer/Inventory/InventoryBG/InventoryItemGridContainer
@onready var chest_item_grid_container: GridContainer = $BG/HBoxContainer/ChestUIContainer/Chest/ChestBG/ChestItemGridContainer

var chest:Chest

func _ready():
	pass

func set_chest(value):
	chest = value

func init_slots():
	# inventory side
	for r in range(0,ROWS): 
		for c in range(0,COLUMNS):
			var slot = INVENTORY_SLOT.instantiate()
			inventory_item_grid_container.add_child(slot)
			var grid_pos = Vector2(c,r)
			var item_data:Item = PlayerData.inventory.get(grid_pos)
			if item_data != null: # item in inventory exists at grid_pos - add to slot
				var inv_item:InventoryItem = INVENTORY_ITEM.instantiate()
				slot.add_child(inv_item)
				inv_item.set_data(item_data.id, item_data.item_amount)
	# chest side
	for r in range(0,chest.ROWS): 
		for c in range(0,chest.COLUMNS):
			var slot = INVENTORY_SLOT.instantiate()
			chest_item_grid_container.add_child(slot)
			var grid_pos = Vector2(c,r)
			var item_data:Item = chest.items.get(grid_pos)
			if item_data != null: # item in inventory exists at grid_pos - add to slot
				var inv_item:InventoryItem = INVENTORY_ITEM.instantiate()
				slot.add_child(inv_item)
				inv_item.set_data(item_data.id, item_data.item_amount)
