extends CharacterBody2D
@export var speed = 400

func _ready() -> void:
	if speed == null:
		speed = 400

func get_input():
	var inputDirection=Input.get_vector("Move Left","Move Right","Move Up","Move Down")
	var isAttacking=false
	if Input.is_action_pressed("Attack"):
		isAttacking=true
	velocity=inputDirection*speed

func attack(event):
	pass

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
	
