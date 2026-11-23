extends Node

class_name Item

@export var id:int
@export var item_amount:int = 0
#@export var max_item_amount:int

func init(new_id:int, amount:int) -> void:
	id = new_id
	item_amount = amount

func _to_string() -> String:
	return str(id) + " " + str(item_amount)
