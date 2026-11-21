# Canvas for menu screens separated from gamepay menus


extends Node2D

@onready var current_stage: CurrentStage = $CurrentStage
@onready var menu_canvas: MenuCanvas = $MenuCanvas

var player

func _ready() -> void:
	current_stage.load_stage(current_stage.HOME)
	player = current_stage.player
	#player.toggle_inventory.connect(menu_canvas.toggle_inventory)
