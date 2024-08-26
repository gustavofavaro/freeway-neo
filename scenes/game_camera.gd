extends Camera2D
class_name GameCamera

var _timer: Timer
var _shaking: bool = false
var _shake_range: float = 5
@onready var _original_pos: Vector2 = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _shaking:
		offset = Vector2(randf_range(-_shake_range, _shake_range), randf_range(-_shake_range, _shake_range))


func _stop_shaking() -> void:
	_shaking = false
	global_position = _original_pos


func shake_camera(amount: float, duration: float) -> void:
	if _timer:
		_timer.stop()
	else:
		_timer = Timer.new()
		add_child(_timer)
		_timer.timeout.connect(_stop_shaking)

	_shaking = true
	_shake_range = amount
	
	_timer.set_wait_time(duration)
	_timer.set_one_shot(true)
	_timer.start()
