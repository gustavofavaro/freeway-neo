extends Area2D
class_name Life


func _on_area_entered(_area: Area2D) -> void:
	GameController.life_collected(1)
	queue_free()
