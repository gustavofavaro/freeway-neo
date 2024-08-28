extends Label
class_name FlashingText

# Called every frame. 'delta' is the elapsed time since the previous frame.

@export var delay: float = 0.3
var counter: float = 0
var enable: bool = true

func set_enable(_enable: bool) -> void:
	enable = _enable

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
	
