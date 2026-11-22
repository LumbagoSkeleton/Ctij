extends Node

class_name Chest

const ROWS = 3
const COLUMNS = 5

var items:Dictionary[Vector2, Item]

func init_item_dictionary():
	for r in range(0,ROWS):
		for c in range(0,COLUMNS):
			items.get_or_add(Vector2(r,c), null)

func open_chest():
	pass
