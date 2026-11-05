class_name Health
extends Node

#add debuffs here later

signal health_changed(difference: int)
signal health_depleted
signal max_health_changed(difference: int)

@export var max_health: int = 100 : set = set_max_health, get = get_max_health
@export var imortality: bool = false :set = set_imortality, get = get_imortality
var imortality_timer: Timer = null
@onready var health: int = max_health : set = set_health, get =get_health

# max health logic here, for debuffs that affect it and such

func set_max_health(value: int):
	#adjust as needed, max health of 1 post debuffs feels too punishing
	var current_max_health = 30 if value <= 30 else value 
	
	if current_max_health != max_health:
		var difference = current_max_health - max_health
		max_health = current_max_health
		max_health_changed.emit(difference)
		
		if health > max_health:
			health = max_health
	
func get_max_health() -> int:
	return max_health
	
# the bulk of the health system, if you re damaged you take damage
	
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

# i frames logic here

func set_imortality(value: bool):
	imortality = value
	
func get_imortality() ->bool:
	return imortality
	
func set_iframes(time: float):
	if imortality_timer == null:
		imortality_timer=Timer.new()
		imortality_timer.one_shot = true
		add_child(imortality_timer)
	
	if imortality_timer.timeout.is_connected(set_imortality):
		imortality_timer.timeout.disconnect(set_imortality)
	
	imortality_timer.set_wait_time(time)
	imortality_timer.timeout.connect(set_imortality.bind(false))
	imortality = true
	imortality_timer.start()
