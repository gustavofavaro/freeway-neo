extends Area2D
class_name Coin

#var fx_res = preload("res://fx/fx_coin.tscn")

#func _ready() -> void:
	#GameController.coins_total += 1

func _on_area_entered(_area: Area2D) -> void:
	#var fx = fx_res.instantiate()
	#get_parent().add_child(fx)
	#fx.global_position = global_position
	
	GameController.coin_collected(10)
	queue_free()
