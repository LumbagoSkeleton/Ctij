class_name HurtBox
extends Area2D

signal recieved_damage(damage: int)

#@export var health # of type health class

func on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		pass
		#take damage once health system is implemented
		# send signal that you took damage
