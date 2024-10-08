extends Area2D
class_name Turbo

var fx_creator: FXCreator

func _ready() -> void:
	fx_creator = $FXCreator
	

func _on_body_entered(body: Node2D) -> void:
	var player: Player = body
	player.global_position = global_position
	player._dash(transform.x)
	fx_creator.create_fx(global_position)
