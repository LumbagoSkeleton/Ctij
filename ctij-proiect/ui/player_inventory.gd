extends Control

class_name PlayerInventory

const INVENTORY_SLOT = preload("res://ui/inventory_slot.tscn")

@onready var inventory_item_grid_container: GridContainer = $BG/InventoryUIContainer/Inventory/InventoryBG/InventoryItemGridContainer

func _ready():
	init_slots()

func init_slots():
	for i in range(0,24): # will change later
		inventory_item_grid_container.add_child(INVENTORY_SLOT.instantiate())
