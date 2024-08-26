extends Node
class_name HotKeys

@export var rect_filter: ColorRect

func _ready() -> void:
	assert(rect_filter, name + ": the shader ColorRect (rect_filter) must be set.")
	rect_filter.visible = GameController.show_filter
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_fullscreen"):
		_toggle_fullscreen()

	if Input.is_action_just_pressed("ui_exit"):
		get_tree().quit()

	if Input.is_action_just_pressed("ui_filter"):
		GameController.show_filter = not GameController.show_filter
		rect_filter.visible = GameController.show_filter


func _toggle_fullscreen() -> void:
	GameController.show_fullscreen = not GameController.show_fullscreen
	
	if GameController.show_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
