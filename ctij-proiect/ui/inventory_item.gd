extends Control

class_name InventoryItem

const ITEM_REGISTRY = preload("res://resources/registries/item_registry.tres")

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func set_data(id:int, amount:int):
	# funky method to fit to load_entry but generally there should only be one entry per id so its ok
	var string_id = ITEM_REGISTRY.filter(&"id", id)[0] 
	var item_resource:ItemEntry = ITEM_REGISTRY.load_entry(string_id)
	print_debug(str(id) + " " + str(item_resource.sprite.resource_path) + " " + str(item_resource.max_amount))
	var texture = item_resource.sprite
	texture_rect.texture = texture
	if amount != -1:
		label.text = str(amount)
