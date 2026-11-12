extends CharacterBody2D

@export var speed = 400
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var movement_direction_var = ""
var inputDirection:Vector2 = Vector2.ZERO # no input
var is_idle = true
var is_left_mouse_pressed = false
var is_left_mouse_held_down = false

func _ready() -> void:
	if speed == null:
		speed = 400
	sprite_2d.play("idle_down")
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			is_left_mouse_pressed= true
			print("caca")
		elif event.button_index == 1 and not event.is_pressed():
			is_left_mouse_pressed = false
	#maybe move all the inputs here later

func _process(delta: float) -> void:
	if is_left_mouse_pressed:
		_is_left_mouse_held_down()
	

func _is_left_mouse_held_down():
	if not is_left_mouse_pressed:
		return # add logic to attack
	await get_tree().create_timer(0.5).timeout
	if not is_left_mouse_pressed:
		return # add logic to attack
	is_left_mouse_held_down = true
	# add logic to flail weapon around as if scared
	
			
func player_movement():
	inputDirection=Input.get_vector("Move Left","Move Right","Move Up","Move Down")
	velocity=inputDirection*speed
	
	if inputDirection:
		is_idle = false

func play_anim(anim_name:String):
	if sprite_2d.animation != anim_name:
		sprite_2d.play(anim_name)

func movement_direction():
	
	# add a default state for when no direction is pressed
	if Input.is_action_pressed("Move Right"):
		
		movement_direction_var = "right"
		play_anim("walk_side")
		sprite_2d.flip_h = false
			
	elif Input.is_action_pressed("Move Left"):
		
		movement_direction_var = "left"
		play_anim("walk_side")
		sprite_2d.flip_h = true
		
	elif Input.is_action_pressed("Move Down"):
		movement_direction_var = "down"
		play_anim("walk_down")
		sprite_2d.flip_h = false
		
	elif Input.is_action_pressed("Move Up"):
		movement_direction_var = "up"
		play_anim("walk_up")
		sprite_2d.flip_h = false

func play_idle_anim():
	if not is_idle:
		is_idle = true
		sprite_2d.stop()
		match movement_direction_var:
			"up":
				play_anim("idle_up")
				sprite_2d.flip_h = false
			"down":
				play_anim("idle_down")
				sprite_2d.flip_h = false
			"left":
				play_anim("idle_side")
				sprite_2d.flip_h = true
			"right":
				play_anim("idle_side")
				sprite_2d.flip_h = false




func _physics_process(delta: float) -> void:
	player_movement()
	move_and_slide()
	movement_direction()
	if inputDirection == Vector2.ZERO:
		play_idle_anim()
