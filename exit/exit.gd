extends Area2D
class_name Exit

var fx_creator: FXCreator

func _ready() -> void:
	fx_creator = $FXCreator

func _on_body_entered(body: Node2D) -> void:
	GameController.level_completed()
	fx_creator.create_fx(global_position)
