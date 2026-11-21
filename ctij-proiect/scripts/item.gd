extends Node

class_name Item

@export var item_amount:int = 0:
	set(value):
		item_amount = value
		if item_amount > max_item_amount:
			item_amount = max_item_amount
@export var max_item_amount:int
