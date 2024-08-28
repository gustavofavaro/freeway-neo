extends Node2D
class_name TitleController

@onready var press: PressStart = $CanvasLayer/PressStart
@onready var fade: FadeRect = $CanvasLayer/Fade


func _ready() -> void:
	#GameController.inject_fade($CanvasLayer/Fade)
	GameController.init_game()
	
	fade.start_fade(1.0, 0.0, 1.0)
	fade.on_fade_done(
		func(): press.set_interactable(true)
	)

	press.set_interactable(false)
	press.on_button_pressed(start_game)


func start_game() -> void:
	press.set_interactable(false)
	fade.start_fade(0.0, 1.0, 1.0)
	fade.on_fade_done(GameController.load_first_level)
