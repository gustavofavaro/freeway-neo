extends Area2D
class_name Turbo


func _on_body_entered(body: Node2D) -> void:
	var player: Player = body
	player.global_position = global_position + Vector2(0, 8)
	player._dash(transform.x)
