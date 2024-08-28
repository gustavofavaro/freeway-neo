extends Label
class_name LabelCoins

@export var delay: float = 0.2

var counter: float = 0
var enable: bool
var callback: Callable

var coins: int = 0
var collected: int = 0
var label: String
var step: int = 1

# Called when the node enters the scene tree for the first time.
func set_coins(_text: String, _current: int, _total: int, _callback: Callable) -> void:
	collected = _total
	callback = _callback
	coins = _current
	label = _text
	
	text = '%s %d' % [label, coins]

func set_enable(_enable: bool) -> void:
	enable = _enable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not enable:
		return
	
	counter += delta
	if counter > delta:
		counter -= delta
		coins += step
		
		if collected-coins <= step:
			coins = collected
			enable = false
			callback.call()
		
		text = '%s %d' % [label, coins]
