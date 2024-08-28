extends Label
class_name PressStart

@export var delay: float = 0.7
@export var key: String = 'ui_accept'

var pressed: bool = false
var callback: Callable
var counter: float = 0

var enable: bool = true

func on_button_pressed(_callback: Callable) -> void:
	callback = _callback

func set_enable(_enable: bool) -> void:
	enable = _enable

func set_interactable(active: bool) -> void:
	pressed = not active

func _process(delta: float) -> void:
	if not enable:
		visible = false
		return
		
	counter += delta
	if counter > delay:
		#var color: Color = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))
		#set("theme_override_colors/font_color", color)
		visible = not visible
		counter -= delay
		
	if not pressed:
		if Input.is_action_just_released(key):
			delay /= 5
			pressed = true
			callback.call()
