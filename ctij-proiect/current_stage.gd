extends Node2D

class_name CurrentStage

const HOME = preload("res://stages/home.tscn")
const PLAYER_CHARACTER = preload("res://player/playerCharacter.tscn")

var player

func load_stage(stage_template): # loads stage and then adds player as child
	var stage = stage_template.instantiate()
	add_child(stage)
	player = PLAYER_CHARACTER.instantiate()
	add_child(player)
