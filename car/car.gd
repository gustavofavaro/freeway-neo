extends Area2D
class_name Car

@export var rotation_interval: float = 0.5
@onready var sprite: Sprite2D = $Sprite2D

#var _counter: float = 0
var _speed: float = 100
var _rotation: float = 0
var _size: Vector2


func init(trans: Transform2D, speed: float):
	transform = trans
	_rotation = global_rotation
	_size = Vector2(24,16)
	_speed = speed


func _process(delta: float) -> void:
	global_position += transform.x * _speed * delta
	
	if global_position.x < -64 or global_position.x > get_viewport_rect().size.x + 64:
		queue_free()
#
	#_counter += delta * 2.5/rotation_interval	
	#global_rotation = _rotation + sin(_counter)/(4 * rotation_interval)


func _on_body_entered(_body: Node2D) -> void:
	#transform.x = -transform.x
	GameController.player_hit()
