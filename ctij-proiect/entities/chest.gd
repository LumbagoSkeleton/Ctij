extends Station

class_name Chest

const ITEM_REGISTRY = preload("uid://c0feiqx4dv1fe")
const ROWS = 3
const COLUMNS = 6

@onready var inventory:Inventory = Inventory.new()

func _ready():
	inventory.set_size(ROWS,COLUMNS)
	populate_chest()

func populate_chest():
	for i in range(0, randi_range(1,5)):
		var item = Item.new()
		var id = randi_range(0,1)
		var entries= ITEM_REGISTRY.filter(&"id", id)
		var entry:ItemEntry = ITEM_REGISTRY.load_entry(entries[0])
		print_debug("entry: " + str(entry.id) + " " + str(entry.max_amount) + " " + str(entry.sprite.resource_path))
		var max_amount = entry.max_amount
		var amount
		if max_amount == -1:
			amount = -1
		else:
			amount = randi_range(1, max_amount)
		item.init(id, amount)
		var grid_pos = Vector2(randi_range(0,COLUMNS),randi_range(0,ROWS))
		inventory.add_item(grid_pos, item)
