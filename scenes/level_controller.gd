extends Node2D
class_name LevelController


func _ready() -> void:
	# injecting object references into GameController
	GameController.inject($Chicken, $HUD, $Camera2D)
	GameController.level_started(0)

	await get_tree().create_timer(1.0).timeout # wait for the tilemap to create the coins
	var items := $Tilemaps/TilemapItems.get_children()
	var total_coins: int = 0
	for item in items:
		if item.is_in_group('coins'):
			total_coins += 1
		
	print('total coins in level: ', total_coins)
	GameController.coins_total = total_coins
