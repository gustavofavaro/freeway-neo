extends Node2D
class_name Clock

@export var level_time: int = 100
@onready var label_time: Label = $LabelClock

var counter: float = 0
var time: int = level_time
var paused: bool = true

func _ready() -> void:
	_update_label()

func set_time(_time: int) -> void:
	time = _time
	_update_label()

func pause_time(pause: bool) -> void:
	paused = pause

func _process(delta: float) -> void:
	if paused:
		return
	counter += delta
	if counter > 1:
		counter -= 1
		time -= 1
		if time == 0:
			time = 0
			paused = true
			GameController.timeup()
		_update_label()

func _update_label() -> void:
	label_time.text = '%03d' % time
