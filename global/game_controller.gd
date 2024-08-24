extends Node
class_name CGameController

var ui_score: Label
var score: int

func coin_collected(points: int) -> void:
	score += points
	ui_score.text = 'SCORE %06d' % score # 000000
