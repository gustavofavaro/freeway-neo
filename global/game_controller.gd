extends Node
class_name CGameController

var total_score: int
var player_lives: int
var game_level: int

# injected access to game elements
var hud: HUD
var player: Player

func inject(_player: Player, _hud: HUD) -> void:
	player  = _player
	hud = _hud

func game_started() -> void:
	total_score = 0
	game_level = 1

func level_started() -> void:
	# fade out
	if player_lives < 3:
		player_lives = 3
	hud.update_lives(player_lives)
	hud.update_score(total_score)
	# message "level start"

func level_completed() -> void:
	# stop player
	# message "level completed"
	# count level score using level time
	# fade in
	# load next level	
	game_level += 1
	player.disable()

func game_over() -> void:
	pass

# player has collected a coin
func coin_collected(points: int) -> void:
	total_score += points
	hud.update_score(total_score)

# player has collected a life
func life_collected(life: int) -> void:
	player_lives += life
	hud.update_lives(player_lives)


func player_hit() -> void:
	#camera shake
	player.restart()
	player_lives -= 1
	hud.update_lives(player_lives)
	if player_lives <= 0:
		game_over()

# game time is up
func timeup() -> void:
	game_over()
