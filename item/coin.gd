extends Area2D
class_name Coin


func _on_area_entered(_area: Area2D) -> void:
	GameController.coin_collected(10)
	queue_free()
