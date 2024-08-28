extends ColorRect
class_name FadeRect

@export var duration: float = 1.0
@export var alpha_start: float = 1
@export var alpha_end: float = 0

var counter: float = 0
var callback: Callable = func(): pass
var active: bool = false

func _ready() -> void:
	visible = true
	color.a = alpha_start


func on_fade_done(_callback: Callable) -> void:
	callback = _callback


func start_fade(alpha1: float, alpha2: float, time: float) -> void:
	alpha_start = alpha1
	alpha_end   = alpha2
	duration = time
	counter = 0
	active = true
	

func _process(delta: float) -> void:
	if not active:
		return
		
	counter += delta
	
	color.a = lerp(alpha_start, alpha_end, counter/duration)	
	
	if counter > duration:
		#assert(callback, name + ": fade callback function must be set")
		if callback:
			active = false
			callback.call()
