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

func add_slot(grid_pos:Vector2i):
	var slot:InventorySlot = INVENTORY_SLOT.instantiate()
	inventory_item_grid_container.add_child(slot)
	slot.grid_pos = grid_pos
	print_debug("slot " + str(slot.grid_pos) + str(get_slot_position(slot)))

func get_slot_at(grid_pos:Vector2i) -> InventorySlot:
	for slot:InventorySlot in inventory_item_grid_container.get_children():
		if slot.grid_pos == grid_pos:
			return slot
	return null

func clear_item_at(grid_pos:Vector2i):
	var slot:InventorySlot = get_slot_at(grid_pos)
	if slot != null:
		slot.remove_child(slot.inv_item)
		slot.inv_item = null

## Getting the position of a slot in UI space
## the   h a r d     way >:)
func get_slot_position(slot:InventorySlot): 
	var base_position:Vector2 = Vector2(-124, -22) # harcoded value for top left corner position
	# add to base position based on slot position in inv grid
	# the 4 is for GridContainer child offset
	base_position += Vector2(slot.grid_pos.x * InventorySlot.WIDTH, slot.grid_pos.y * InventorySlot.HEIGHT)
	#print_debug("position for slot with grid_pos " + str(slot.grid_pos) + ": " + str(base_position))
	return base_position

## Gets the closest slot to a certain position in UI space
func get_closest_slot(item_position:Vector2):
	item_position += Vector2(InventorySlot.WIDTH, InventorySlot.HEIGHT) # approx one tile worth offset
	var closest_slot:InventorySlot = null
	var closest_distance = 9999999 # outrageous num to init min
	#print_debug("position to begin: " +str(item_position))
	for slot:InventorySlot in inventory_item_grid_container.get_children():
		var ui_space_pos = get_slot_position(slot)
		if item_position.distance_to(ui_space_pos) <= closest_distance:
			closest_distance = item_position.distance_to(ui_space_pos)
			closest_slot = slot
			#print_debug("new closest slot " + str(slot.grid_pos) + " with distance " + str(closest_distance))
	return closest_slot

func update_from_inventory(): # subsequent loads - only update already existent slots
	clear() # clears items in inv
	for grid_pos in PlayerData.inventory.items.keys(): # readds every item at their slot
		var item_to_add = PlayerData.inventory.get_item_at_grid_pos(grid_pos)
		add_item(grid_pos, item_to_add)

func add_item(grid_pos:Vector2i, item:Item):
	var slot = get_slot_at(grid_pos)
	if slot != null:
		var inv_item = INVENTORY_ITEM.instantiate()
		slot.add_child(inv_item)
		slot.inv_item = inv_item
		inv_item.set_data(item.id, item.item_amount)
		inv_item.snap_to_slot.connect(func(item_pos):
			# move item in data inventory
			# no need for visual changes those already come from inventory.updated_items
			var slot_to_snap = get_closest_slot(item_pos)
			inventory_move_item(item, slot_to_snap.grid_pos)
			#print_debug(slot_to_snap.grid_pos)
		)

func clear():
	for slot:InventorySlot in inventory_item_grid_container.get_children():
		slot.remove_child(slot.inv_item)
		slot.inv_item = null

func inventory_move_item(item:Item, grid_pos:Vector2i):
	# the server owns the inventory now, so the move travels as an action; the authoritative
	# state comes back and refreshes the visual through inventory.updated_items
	var source_grid_pos = PlayerData.inventory.get_grid_pos_of_item(item)
	if source_grid_pos == null:
		return
	PlayerData.inventory.move_item(grid_pos, item)
