extends Area2D
class_name Car

@export var rotation_interval: float = 0.5

#var _counter: float = 0
var _speed: float = 100
var _rotation: float = 0
var _final_position: float
var _size: Vector2


func init(trans: Transform2D, speed: float):
	transform = trans
	_rotation = global_rotation
	_size = $Sprite.get_rect().size
	_final_position = global_position.x + transform.x.x * (get_viewport_rect().size.x + _size.x*2)
	_speed = speed


func _process(delta: float) -> void:
	global_position += transform.x * _speed * delta
	
	#if abs(global_position.x - _final_position) <= speed * delta:
		#queue_free()
#
	#_counter += delta * 2.5/rotation_interval	
	#global_rotation = _rotation + sin(_counter)/(4 * rotation_interval)


func _on_body_entered(body: Node2D) -> void:
	transform.x = -transform.x
