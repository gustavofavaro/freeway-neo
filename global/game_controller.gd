extends Node
class_name CGameController

const SCORE_FORMAT: String = 'SCORE %06d'

var total_score: int
var player_lives: int
var game_level: int = 1
var scene_index: int 
var base_speed: float = 1	# enemies speed factor

var coins_total: int
var coins_collected: int

var show_fullscreen: bool = false
var show_filter: bool = true
var show_particles: bool = true

# injected access to game elements
var hud: HUD
var player: Player
var camera: GameCamera

func inject(_player: Player, _hud: HUD, _camera: GameCamera) -> void:
	player  = _player
	hud = _hud
	camera = _camera

### GAME LIFECYCLE ################################################

func init_game() -> void:
	total_score = 0
	game_level = 1
	scene_index = 1
	base_speed = 1
	
func level_started(coins: int) -> void:
	coins_total = coins
	coins_collected = 0
	hud.show_level(true)
	player.set_enable(false)
	hud.do_fade(1.0, 0.0, 1.0, start_player)
	
	if player_lives < 3:
		player_lives = 3
	hud.update_lives(player_lives)
	hud.update_score(total_score)


func start_player() -> void:
	await get_tree().create_timer(1.0).timeout
	player.set_enable(true)
	hud.show_level(false)
	hud.enable_clock(true)

func show_end_msg_and_call(msg: String, callback: Callable) -> void:
	hud.enable_clock(false)
	hud.show_message(msg)
	player.set_enable(false)
	await get_tree().create_timer(2.0).timeout
	hud.do_fade(0.0, 1.0, 1.0, callback)

func level_completed() -> void:
	# count level score (+time?) (+all coins?)
	player.visible = false
	show_end_msg_and_call("GOOD JOB!", load_level_clear)

# game time is up
func timeup() -> void:
	show_end_msg_and_call("TIME'S UP", load_game_over)

func game_over() -> void:
	show_end_msg_and_call("OH NOES!", load_game_over)

### GAME EVENTS ###################################################

# player has collected a coin
func coin_collected(points: int) -> void:
	coins_collected += 1
	total_score += points
	hud.update_score(total_score)

# player has collected a life
func life_collected(life: int) -> void:
	player_lives += life
	hud.update_lives(player_lives)

# player has taken damage
func player_hit() -> void:
	if player.invincible:
		return
	camera.shake_camera(1, 0.2)
	player_lives -= 1
	player.set_invincible(true)
	hud.update_lives(player_lives)
	if player_lives <= 0:
		player.destroy()
		game_over()
	else:
		player.restart()

### SCENES LOADING ################################################

func load_first_level() -> void:
	get_tree().change_scene_to_file("res://levels/level1.tscn")
	
func load_level_clear() -> void:
	get_tree().change_scene_to_file("res://scenes/clear/level_clear.tscn")

func load_game_over() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over/game_over.tscn")

func load_title() -> void:
	init_game()
	get_tree().change_scene_to_file("res://scenes/title/title.tscn")

func load_next_level() -> void:
	game_level += 1
	scene_index+= 1
	
	if not ResourceLoader.exists("res://levels/level%d.tscn" % scene_index):
		scene_index = 1
		base_speed += 0.2 # increase 20% per round

	get_tree().change_scene_to_file("res://levels/level%d.tscn" % scene_index)
