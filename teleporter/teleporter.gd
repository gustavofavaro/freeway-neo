extends Area2D
class_name Teleporter

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

var count: float = 0

func _process(delta: float) -> void:
	animatedSprite.rotation += delta
	
	var _scale = 0.2 + abs(sin(count))
	animatedSprite.scale = Vector2(_scale, _scale)
	count += 0.5

func _on_body_entered(body: Node2D) -> void:
	body.global_position = $Destination.global_position
