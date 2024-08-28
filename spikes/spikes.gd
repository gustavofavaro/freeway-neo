extends Area2D
class_name Spikes

func _on_body_entered(_player: Player) -> void:
	GameController.player_hit()
