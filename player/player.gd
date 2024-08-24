extends CharacterBody2D
class_name Player

@export var SPEED: float = 100
@onready var _animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var _animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

enum PlayerState {CONTROLLING, MOVING, STOPPED}

var _screen_size: Vector2
var _size: Vector2
var input: Vector2
var next_input: Vector2
var next_pos: Vector2
var state: PlayerState
var timer: Timer

func _ready() -> void:
	_screen_size = get_viewport_rect().size
	_size = $AnimatedSprite2D.sprite_frames.get_frame_texture('run_up',0).get_size() # *  $AnimatedSprite2D.scale	


func _get_input() -> void:
	#var input: Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if Input.is_action_just_pressed("ui_left"):
		input = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		input = Vector2.RIGHT
	elif Input.is_action_just_pressed("ui_up"):
		input = Vector2.UP
	elif Input.is_action_just_pressed("ui_down"):
		input = Vector2.DOWN
	
	#var ipos: Vector2i = global_position
	#if ipos.x % 16 == 0 and ipos.y % 16 == 0:
		#global_position = ipos/16 * 16
		#input = next_input
	

func _move_player() -> void:
	if input:
		velocity = input * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()
	
	global_position.x = wrap(global_position.x, 0, _screen_size.x)
	global_position.y = clamp(global_position.y, 0, _screen_size.y - _size.y/2)


func _dash(direction: Vector2) -> void:
	input = Vector2i(direction)
	state = PlayerState.MOVING
	SPEED = 300
	
	if timer != null: 
		timer.stop()
	else:	  
		timer = Timer.new()
		add_child(timer)
	
	timer.start(0.25)
	await timer.timeout
	
	state = PlayerState.CONTROLLING
	SPEED = 100


func _physics_process(_delta: float) -> void:
	match state:
		PlayerState.MOVING:
			_move_player()
			
		PlayerState.CONTROLLING:
			_get_input()
			_move_player()
			
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
