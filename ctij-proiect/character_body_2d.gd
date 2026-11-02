extends CharacterBody2D
@export var speed = 400


func getInput():
	var inputDirection=Input.get_vector("Move Left","Move Right","Move Up","Move Down")
	velocity=inputDirection*speed


func _physics_process(delta: float) -> void:
	getInput()
	move_and_slide()
	
