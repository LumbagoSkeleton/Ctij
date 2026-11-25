extends Control

class_name InventoryItem

const ITEM_REGISTRY = preload("res://resources/registries/item_registry.tres")

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label
@onready var is_draggable: Label = $is_draggable

var draggable:bool = false
var dragged:bool = false

func set_data(id:int, amount:int):
	# funky method to fit to load_entry but generally there should only be one entry per id so its ok
	var string_id = ITEM_REGISTRY.filter(&"id", id)[0] 
	var item_resource:ItemEntry = ITEM_REGISTRY.load_entry(string_id)
	#print_debug(str(id) + " " + str(item_resource.sprite.resource_path) + " " + str(item_resource.max_amount))
	var texture = item_resource.sprite
	texture_rect.texture = texture
	if amount != -1:
		label.text = str(amount)

const DRAG_SPEED = 100

signal snap_to_slot(position) # sends position in ui space adn lets the inventory snap it to the closest slot

var slot_to_snap_to:InventorySlot


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed(): # possible drag
			if draggable and not dragged:
				dragged = true
				print_debug(get_global_mouse_position())
				print_debug(position)
		elif event.is_released(): # end drag
			if dragged:
				dragged = false
				print_debug("item position " + str(global_position))
				snap_to_slot.emit(global_position)

func _process(delta: float) -> void:
	if draggable:
		is_draggable.text = "yes"
	else:
		is_draggable.text = "no"
	if draggable and dragged:
		#position = lerp(position, Vector2(DisplayServer.mouse_get_position().x, 
		#DisplayServer.mouse_get_position().y / 1.5), 0.25)
		#position = Vector2(DisplayServer.mouse_get_position().x, DisplayServer.mouse_get_position().y)
		#position = Vector2(get_global_mouse_position().x - 180, get_global_mouse_position().y - 100) 
		global_position = get_global_mouse_position() - Vector2(12,0)


func _on_icon_mouse_entered() -> void:
	#print_debug("can mouse")
	draggable = true


func _on_icon_mouse_exited() -> void:
	#print_debug("no can mouse")
	if not dragged: # prevent accidental undraggability
		draggable = false
