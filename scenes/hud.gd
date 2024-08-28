extends CanvasLayer
class_name HUD

@export var level_time: int = 100

@onready var label_score: Label = $LabelScore
@onready var clock: Clock = $Clock
@onready var texture_lives: TextureRect = $TextureRectLives
@onready var fade: FadeRect = $Fade
@onready var msg_level: Label = $MsgLevel
@onready var label_level: Label = $LabelLevel
@onready var label_lives: Label = $TextureRectLives/LabelLives
@onready var rect_bg: ColorRect = $ColorRectBg


func _ready() -> void:
	clock.set_time(level_time)

func do_fade(alpha1: float, alpha2: float, time: float, callback: Callable) -> void:
	fade.start_fade(alpha1, alpha2, time)
	fade.on_fade_done(callback)

func update_lives(lives: int) -> void:
	#texture_lives.size.x = lives * 18
	label_lives.text = 'x%02d' % lives

func update_score(score: int) -> void:
	label_score.text = GameController.SCORE_FORMAT % score # 000000

func enable_clock(enable: bool) -> void:
	clock.paused = not enable

func show_level(_visible: bool) -> void:
	msg_level.text = 'LEVEL %d' % GameController.game_level
	label_level.text = msg_level.text
	msg_level.visible = _visible
	
func show_message(text: String) -> void:
	msg_level.text = text
	msg_level.visible = visible	
