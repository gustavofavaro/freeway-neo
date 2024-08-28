extends Node2D
class_name LevelClearController

@onready var press: PressStart = $CanvasLayer/PressStart
@onready var fade: FadeRect = $CanvasLayer/Fade

@onready var bonus: PressStart = $CanvasLayer/LabelBonus
@onready var coins: LabelCoins = $CanvasLayer/LabelCoins
@onready var score: LabelCoins = $CanvasLayer/LabelScore


func update_text() -> void:
	score.text = GameController.SCORE_FORMAT % GameController.total_score # 000000'
	
func _ready() -> void:
	#GameController.coins_collected = 100
	#GameController.coins_total = 100

	coins.set_coins('COINS', 0, GameController.coins_collected, check_bonus)	
	coins.set_enable(false)
	
	score.set_enable(false)
	score.set_coins('TOTAL SCORE', GameController.total_score, GameController.total_score, allow_start)	
	
	fade.start_fade(1.0, 0.0, 1.0)
	fade.on_fade_done(count_coins)
	
	press.set_enable(false)
	press.on_button_pressed(next_level)

	bonus.set_enable(false)
	bonus.on_button_pressed(func(): pass)
	
func count_coins() -> void:
	await get_tree().create_timer(0.5).timeout
	coins.set_enable(true)

func check_bonus() -> void:
	await get_tree().create_timer(0.5).timeout

	var add_bonus: bool = GameController.coins_collected == GameController.coins_total
	if add_bonus:
		bonus.set_enable(true)
		GameController.total_score += 1000
	
	await get_tree().create_timer(0.5).timeout
	score.step = 20
	score.collected = GameController.total_score
	score.set_enable(true)
	
func allow_start() -> void:
	await get_tree().create_timer(0.5).timeout
	press.set_enable(true)


func next_level() -> void:
	press.set_interactable(false)
	fade.start_fade(0.0, 1.0, 1.0)
	fade.on_fade_done(GameController.load_next_level)
