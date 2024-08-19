extends Node2D
class_name FullScreenToggle

var _activated: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_fullscreen"):
		_toggle_fullscreen()


func _toggle_fullscreen() -> void:
	_activated = not _activated
	
	if _activated:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
