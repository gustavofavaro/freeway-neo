extends Node2D
class_name HUD

@onready var label_score: Label = $LabelScore
@onready var clock: Clock = $Clock
@onready var texture_lives: TextureRect = $TextureRectLives

func update_lives(lives: int) -> void:
	texture_lives.size.x = lives * 18
	
func update_score(score: int) -> void:
	label_score.text = 'SCORE %06d' % score # 000000
