# Global script with generally useful player data

extends Node

const ITEM_REGISTRY = preload("uid://c0feiqx4dv1fe")

var inventory:Dictionary[Vector2i, Item]
enum State { IDLE, IN_MENU }
var state:State = State.IDLE

func _ready():
	populate_inventory()

func populate_inventory(): # temp function to test inventory mechanics
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
		var grid_pos = Vector2(randi_range(0,5),randi_range(0,3))
		inventory.get_or_add(grid_pos,item)

func update_item(grid_pos:Vector2i, item:Item):
	inventory[grid_pos] = item
	print_debug(inventory)
	#updatedinventory.emit()

func move_item(item:Item, new_grid_pos:Vector2i):
	var old_grid_pos = get_grid_pos_of_item(item)
	var item_at_new_pos = get_item_at_grid_pos(new_grid_pos)
	if item_at_new_pos == null: # no item already at this pos - place item directly
		inventory[new_grid_pos] = item
		inventory.erase(old_grid_pos)
		print_debug(inventory)
	else: # item already at grid pos - swap items around
		inventory[new_grid_pos] = item
		inventory[old_grid_pos] = item_at_new_pos
	#updated_items.emit()

func remove_item_at(grid_pos:Vector2i):
	inventory.erase(grid_pos)
	print_debug(inventory)
	#updated_items.emit()

func get_item_at_grid_pos(grid_pos:Vector2i):
	if inventory.has(grid_pos):
		return inventory[grid_pos]
	return null

func get_grid_pos_of_item(item:Item):
	for grid_pos in inventory:
		if inventory[grid_pos] == item:
			return grid_pos
	return null
