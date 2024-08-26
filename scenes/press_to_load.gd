extends Label
class_name PressToLoad

@export_file('*.tscn') var scene_to_load: String
@export var key: String = 'ui_accept'

func _ready() -> void:
	assert(scene_to_load, name + ": scene to load must be set.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released(key):
		get_tree().change_scene_to_file(scene_to_load)
