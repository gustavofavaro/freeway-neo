extends Sprite2D
class_name Spawner

@export var launch_speed: float = 70
@export var pattern: Array[String] = ['A','A','','A','','']

#  how many seconds to wait = car size / car speed per second
var launch_rate: float = 24 / launch_speed
#@export_file('*.tscn') var resource: String

var _car_table: Dictionary = {
	'A': ['res://car/car.tscn', null]
}
#var _car_res: Array[Resource]
var _counter: float = 0
var _idx: int = 0


func _ready() -> void:
	for key in _car_table:
		_car_table[key][1] = load(_car_table[key][0])


func _process(delta: float) -> void:
	_counter += delta
	
	if _counter > launch_rate:
		_counter -= launch_rate
		_launch_car()


func _launch_car() -> void:
	if not pattern[_idx].is_empty():
		var car: Car = _car_table['A'][1].instantiate()
		get_parent().add_child(car)
		car.init(transform, launch_speed)
		
	_idx = (_idx + 1) % len(pattern) # wrap around pattern list
