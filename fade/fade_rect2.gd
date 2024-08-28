extends ColorRect
class_name FadeRect2

@export var duration: float = 1.0

var counter: float = 0
var callback: Callable

func _ready() -> void:
	pass


func on_fade_done(_callback: Callable) -> void:
	callback = _callback


func _process(delta: float) -> void:
	pass
