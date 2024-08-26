extends Node2D
class_name LevelController


func _ready() -> void:
	# injecting object references into GameController
	GameController.inject($Chicken, $CanvasLayer/HUD, $Camera2D)
	GameController.level_started()
