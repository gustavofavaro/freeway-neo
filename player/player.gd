extends CharacterBody2D
class_name Player

@export var SPEED: float = 100
@onready var _animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var _animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

enum PlayerState {CONTROLLING, MOVING, STOPPED}

var _screen_size: Vector2
var _size: Vector2
var start_position: Vector2
var input: Vector2
var next_input: Vector2
var next_pos: Vector2
var state: PlayerState
var invincible: bool
var timer: Timer

@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var fx_death: FXCreator = $FXCreatorDeath
@onready var fx_reset: FXCreator = $FXCreatorReset

@onready var wall_detector: Node2D = $WallDetector
@onready var raycast1: RayCast2D = $WallDetector/RayCast2D1
@onready var raycast2: RayCast2D = $WallDetector/RayCast2D2

func _ready() -> void:
	_screen_size = get_viewport_rect().size
	_size = $AnimatedSprite2D.sprite_frames.get_frame_texture('run_up',0).get_size() # *  $AnimatedSprite2D.scale	
	particles.emitting = false
	start_position = global_position
	set_invincible(true)


func destroy() -> void:
	fx_death.create_fx(global_position)
	visible = false

func restart() -> void:
	destroy()
	visible = true
	global_position = start_position
	fx_reset.create_fx(global_position)
	input = Vector2.ZERO


func set_invincible(_invincible: bool) -> void:
	invincible = _invincible 
	if invincible:
		await get_tree().create_timer(0.5).timeout
		invincible = false


func set_enable(enable: bool) -> void:
	if enable:
		process_mode = ProcessMode.PROCESS_MODE_INHERIT
	else:
		process_mode = ProcessMode.PROCESS_MODE_DISABLED


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


func _correct_corner_hit() -> Vector2:
	var correction: Vector2 = Vector2.ZERO

	if input.y != 0:
		raycast1.position.y = -5.5
		raycast2.position.y =  5.5
	else:
		raycast1.position.y = -3.5
		raycast2.position.y =  3.5

	wall_detector.rotation = input.angle()
	if raycast1.is_colliding() != raycast2.is_colliding():
		if raycast1.is_colliding():
			correction = -(raycast1.global_position - wall_detector.global_position).normalized()
		else:
			correction = -(raycast2.global_position - wall_detector.global_position).normalized()
		#print(correction)
	
	return correction


func _move_player() -> void:
	var correction = _correct_corner_hit()
	
	if input:
		velocity = (input + correction) * SPEED
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
		particles.emitting = true
		_animationPlayer.play('run')
	else:
		particles.emitting = false
		_animationPlayer.play('idle')
		_animatedSprite.frame = 0
		_animatedSprite.stop()
