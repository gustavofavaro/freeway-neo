extends Area2D
class_name Teleporter

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var destination: Marker2D = $Destination
@onready var fx_creator: FXCreator = $FXCreator

var count: float = 0

func _process(delta: float) -> void:
	animatedSprite.rotation += delta
	
	var _scale = 0.4 + abs(sin(count))/2
	animatedSprite.scale = Vector2(_scale, _scale)
	count += 0.5
	
	particles.rotation += delta


func _on_body_entered(body: Node2D) -> void:
	fx_creator.create_fx(destination.global_position)	
	body.global_position = destination.global_position


func _on_area_entered(area: Area2D) -> void:
	fx_creator.create_fx(destination.global_position)	
	area.global_position = destination.global_position
