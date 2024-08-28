extends TileMapLayer
class_name ScrollingTilemap

@export var speed: float = 100
@onready var screen_width: float = get_viewport_rect().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= delta * speed
	if global_position.x < -screen_width:
		global_position.x += screen_width
