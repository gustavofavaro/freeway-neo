extends Node2D
class_name TitleController

@export var speed: float = 10
@onready var screen_width: float = get_viewport_rect().size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= delta * speed
	if global_position.x < -screen_width:
		global_position.x += screen_width
