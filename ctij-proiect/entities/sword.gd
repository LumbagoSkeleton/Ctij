extends Node2D

var sword_position: int : set = set_sword_position, get =get_sword_position

func set_sword_position(position : int):
	sword_position = position
	
func get_sword_position() -> int:
	return sword_position

func move_to_mouse ():
	
