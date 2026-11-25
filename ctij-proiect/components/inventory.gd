# Node that manages a collection of items and its manipulation
# Use as component of any object that would have an item storage (ex: player, chest etc.)

extends Node

class_name Inventory

const ITEM_REGISTRY = preload("uid://c0feiqx4dv1fe")

var ROWS
var COLUMNS

signal updated # connected to ui component, lets ui know to refresh itself

var items:Dictionary[Vector2i, Item] # dictionary containing every item and its position on the inventory grid

func set_size(rows:int, columns:int):
	ROWS = rows
	COLUMNS = columns

func add_item(grid_pos:Vector2i, item:Item):
	items.get_or_add(grid_pos, item)
	updated.emit()

func update_item(grid_pos:Vector2i, item:Item):
	items[grid_pos] = item
	updated.emit()

func move_item(new_grid_pos:Vector2i, item:Item):
	var old_grid_pos = items.find_key(item)
	if items.has(new_grid_pos):
		var new_pos_item = items.get(new_grid_pos)
		if item.id == new_pos_item.id: # stack identical items
			stack_items(old_grid_pos, new_grid_pos)
		else:
			items.erase(old_grid_pos)
			items.erase(new_grid_pos)
			items.get_or_add(old_grid_pos, new_pos_item)
			items.get_or_add(new_grid_pos, item)
	else:
		items.erase(old_grid_pos)
		items.get_or_add(new_grid_pos, item)
	updated.emit()

func remove_item(grid_pos:Vector2i):
	items.erase(grid_pos)
	updated.emit()

func stack_items(old_grid_pos:Vector2i, new_grid_pos:Vector2i):
	var old_item:Item = items.get(old_grid_pos)
	var new_item:Item = items.get(new_grid_pos)
	if old_item.id != new_item.id:
		return
	var item_data:ItemEntry = ITEM_REGISTRY.load_entry(ITEM_REGISTRY.filter(&"id", old_item.id)[0])
	if old_item.item_amount + new_item.item_amount > item_data.max_amount: # overflow - 2 items
		old_item.item_amount += new_item.item_amount
		old_item.item_amount -= item_data.max_amount
		new_item.item_amount = item_data.max_amount
	else: # no overflow - stacked into 1 item
		new_item.item_amount += old_item.item_amount
		items.erase(old_grid_pos)
	updated.emit() # kinda unnecessary since its not yet used as a standalone operation but eh

func get_item_at_grid_pos(grid_pos:Vector2i):
	if items.has(grid_pos):
		return items[grid_pos]
	return null

func get_grid_pos_of_item(item:Item):
	return items.find_key(item)
