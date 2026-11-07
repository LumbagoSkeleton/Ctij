extends CharacterBody2D

@export var speed = 400

var movement_direction_var = ""

func _ready() -> void:
	if speed == null:
		speed = 400
		
func player_movement():
	var inputDirection=Input.get_vector("Move Left","Move Right","Move Up","Move Down")
	velocity=inputDirection*speed

func movement_direction():
	
	# add a default state for when no direction is pressed
	if Input.is_action_pressed("Move Right"):
		
		movement_direction_var = "right"
		$Sprite2D.texture =load("res://assets/ctij_mc_walk_side.png")
		$Sprite2D.flip_h = false
			
	if Input.is_action_pressed("Move Left"):
		
		movement_direction_var = "left"
		$Sprite2D.texture = load("res://assets/ctij_mc_walk_side.png")
		$Sprite2D.flip_h = true
		
	if Input.is_action_pressed("Move Down"):
		movement_direction_var = "down"
		$Sprite2D.texture = load("res://assets/ctij_mc_walk_down.png")
		
	if Input.is_action_pressed("Move Up"):
		
		movement_direction_var = "up"
		$Sprite2D.texture = load("res://assets/ctij_mc_walk_up.png")

func _physics_process(delta: float) -> void:
	player_movement()
	move_and_slide()
	movement_direction()
	
