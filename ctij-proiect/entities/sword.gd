class_name Sword
extends Node2D

var sword_position: Vector2 : set = set_sword_position, get =get_sword_position

func set_sword_position(position : Vector2):
	sword_position = position
	
func get_sword_position() -> Vector2:
	return sword_position
