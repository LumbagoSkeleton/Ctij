# Global script with generally useful player data

extends Node

const ITEM_REGISTRY = preload("uid://c0feiqx4dv1fe")

@onready var inventory:Inventory = Inventory.new()
enum State { IDLE, IN_MENU }
var state:State = State.IDLE

func _ready():
	populate_inventory()

func populate_inventory(): # temp function to test inventory mechanics
	inventory.set_size(4,6)
	#print_debug(ITEM_REGISTRY.get_indexed_properties())
	for i in range(0, randi_range(1,5)):
		var item = Item.new()
		var id = randi_range(0,1)
		var entries= ITEM_REGISTRY.filter(&"id", id)
		var entry:ItemEntry = ITEM_REGISTRY.load_entry(entries[0])
		#print_debug("entry: " + str(entry.id) + " " + str(entry.max_amount) + " " + str(entry.sprite.resource_path))
		var max_amount = entry.max_amount
		var amount
		if max_amount == -1:
			amount = -1
		else:
			amount = randi_range(1, max_amount)
		item.init(id, amount)
		var grid_pos = Vector2(randi_range(0,inventory.COLUMNS-1),randi_range(0,inventory.ROWS-1))
		inventory.add_item(grid_pos,item)
