extends Area2D
class_name Teleporter


func _on_body_entered(body: Node2D) -> void:
	body.global_position = $Destination.global_position
