class_name Health
extends Node

#add debuffs here later

signal health_changed(difference: int)
signal health_depleted
signal max_health_changed(difference: int)

@export var max_health: int = 100 : set = set_max_health, get = get_max_health
@onready var health: int = max_health : set = set_health, get =get_health

func set_max_health(value: int):
	#adjust as needed, max health of 1 post debuffs feels too punishing
	var current_max_health = 1 if value <= 0 else value 
	
	if current_max_health != max_health:
		var difference = current_max_health - max_health
		max_health = current_max_health
		max_health_changed.emit(difference)
		
		if health > max_health:
			health = max_health
	
func get_max_health() -> int:
	return max_health
	
func set_health(value:int):
	
	var current_health = clampi(value, 0, max_health)
	if current_health != health:
		var difference = current_health - health
		health = value
		health_changed.emit(difference)
		if health <= 0:
			health_depleted.emit()

func get_health() -> int:
	return health
