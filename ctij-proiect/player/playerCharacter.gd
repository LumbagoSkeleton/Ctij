extends CharacterBody2D

@export var speed = 400
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var movement_direction_var = ""
var inputDirection:Vector2 = Vector2.ZERO # no input
var is_idle = true
var is_left_mouse_pressed = false
var is_left_mouse_held_down = false
var player_sword : Sword

func _ready() -> void:
	if speed == null:
		speed = 150
	sprite_2d.play("idle_down")
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			is_left_mouse_pressed= true
		elif event.button_index == 1 and not event.is_pressed():
			is_left_mouse_pressed = false
	#maybe move all the inputs here later

func _process(delta: float) -> void:
	if is_left_mouse_pressed:
		_is_left_mouse_held_down()
	

func _is_left_mouse_held_down():
	is_left_mouse_held_down = false
	if not is_left_mouse_pressed:
		is_left_mouse_held_down = false
		return 	
	await get_tree().create_timer(0.5).timeout
	if not is_left_mouse_pressed:
		is_left_mouse_held_down = false
		return 
		
	is_left_mouse_held_down = true
	
			
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

func move_sword():
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var viewport_size = get_viewport().get_visible_rect().size
	var viewport_center = viewport_size / 2
	var relative_mouse_position = viewport_center - mouse_position
	
	if relative_mouse_position.y < -abs(relative_mouse_position.x):
		pass
		# mouse is in bottom wedge of the screen
	elif  relative_mouse_position.y > abs(relative_mouse_position.x):
		pass
		# mouse is in top wedge of the screen
	elif relative_mouse_position.x < 0:
		pass
		# mouse is in right wedge of the screen
	else:
		pass
		# mouse is in left wedge of the screen

func _physics_process(delta: float) -> void:
	player_movement()
	move_sword()
	move_and_slide()
	movement_direction()
	if inputDirection == Vector2.ZERO:
		play_idle_anim()
