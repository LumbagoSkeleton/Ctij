extends Node2D

enum State {IDLE, WALKING, AGGRO}
var state:State = State.WALKING

var target_player
var walk_speed = 40
var aggro_speed = 110
var target_position
var init_position

func _physics_process(delta: float) -> void:
	if state == State.AGGRO:
		if position.distance_to(target_player.position) > 30:
			var direction = (position - target_player.position).normalized()
			position -= direction * aggro_speed * delta
	else:
		scan_for_player()

func distance_from_player():
	if target_player != null:
		return position.distance_to(target_player.position)
	return null

func scan_for_player():
	var begin_point = position
	var scan_length:Vector2 = Vector2(0,120)
	var space_state = get_world_2d().direct_space_state
	for angle in range(0,360):
		var end_point = position + scan_length.rotated(deg_to_rad(angle))
	
		# use global coordinates, not local to node
		var query = PhysicsRayQueryParameters2D.create(begin_point, end_point)
		var result = space_state.intersect_ray(query)
		if result and result["collider"] is Player:
			#print_debug("player found")
			target_player = result["collider"]
			state = State.AGGRO
func _on_health_health_depleted() -> void:
	queue_free() # dies
