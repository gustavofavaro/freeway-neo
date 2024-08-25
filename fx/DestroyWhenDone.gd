extends Node2D
class_name DestroyWhenDone

@export var time: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CPUParticles2D.emitting = true
	await get_tree().create_timer(time).timeout
	queue_free()
