extends CharacterBody2D
class_name Player

@export var SPEED: float = 100
@onready var _animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var _animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

var _screen_size: Vector2
var _size: Vector2

func _ready() -> void:
	_screen_size = get_viewport_rect().size
	_size = $AnimatedSprite2D.sprite_frames.get_frame_texture('run_up',0).get_size() # *  $AnimatedSprite2D.scale


func _physics_process(_delta: float) -> void:
	var input: Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")

	if input:
		velocity = input * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()
	
	global_position.x = wrap(global_position.x, 0, _screen_size.x)
	global_position.y = clamp(global_position.y, 0, _screen_size.y - _size.y/2)
	animate()

	
func animate() -> void:
	if velocity:
		if velocity.y > 0:
			_animatedSprite.play('run_down')
		elif velocity.y < 0:
			_animatedSprite.play('run_up')
			
		if velocity.x > 0:
			_animatedSprite.play('run_right')
		elif velocity.x < 0:
			_animatedSprite.play('run_left')
	
	if velocity:
		_animationPlayer.play('run')
	else:
		_animationPlayer.play('idle')
		_animatedSprite.frame = 0
		_animatedSprite.stop()
