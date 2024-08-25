extends Node2D
class_name FXCreator

@export_file('*.tscn') var resource_path: String
@onready var resource: Resource = load(resource_path)

func _ready() -> void:
	assert(resource_path, name + ": resource path must be set.")

func create_fx(pos: Vector2) -> void:
	var fx = resource.instantiate()
	fx.global_position = pos
	get_parent().get_parent().add_child(fx)
