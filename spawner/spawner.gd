extends Sprite2D
class_name Spawner

##################################################
class Entry:
	enum {RED, GREEN, BLUE, YELLOW, GRAY, PURPLE, NONE, SPAWN_RIGHT, SPAWN_LEFT}
	
	var type: int = 0
	var speed: float = 1
	
	func _init(_type: int, _speed: float) -> void:
		self.type = _type
		self.speed = _speed
		
##################################################
class Pattern:
	var list: Array[Entry] = []
	var idx: int = 0
	var dir: int = 1
	
	func append(type: int, speed: float) -> void:
		list.append(Entry.new(type, speed))
	
	func get_next() -> Entry:
		var next: Entry = list[idx]
		#idx = (idx + 1) % len(list) # wrap around pattern list
		idx += dir
		if idx < 0: idx = len(list)-1
		elif idx > len(list)-1: idx = 0
		#wrapi(dir, 0, len(list)-1)

		return next
		
	func set_direction(_dir: int) -> void:
		dir = _dir
		if dir < 0:
			idx = len(list)-1
	
##################################################
class CarResource:
	var path: String
	var scene: Resource
	
	func _init(_path: String) -> void:
		self.path = _path
		self.scene= null

##################################################
@export var launch_speed: float = 70
@export var pattern_str: String = 'A-AA-AAA----'

# car resource tables
var resource_table: Array[CarResource] = [
	CarResource.new('res://car/car.tscn'), # type 0
	CarResource.new('res://car/car.tscn'), # type 1
	CarResource.new('res://car/car.tscn'), # type 2
	CarResource.new('res://car/car.tscn'), # type 3
	CarResource.new('res://car/car.tscn'), # type 4
	CarResource.new('res://car/car.tscn')  # type 5
]

#  how many seconds to wait = car size / car speed per second
var launch_rate: float = 24 / launch_speed
var counter: float = 0
var idx: int = 0

var pattern: Pattern

func _set_default_pattern() -> void:
	pattern = Pattern.new()
	pattern.append(Entry.RED, 70)
	pattern.append(Entry.RED, 70)
	pattern.append(Entry.RED, 70)
	pattern.append(Entry.NONE, 70)
	pattern.append(Entry.NONE, 70)
	pattern.append(Entry.NONE, 70)
	pattern.append(Entry.RED, 70)
	pattern.append(Entry.NONE, 70)
	pattern.append(Entry.NONE, 70)
	pattern.append(Entry.NONE, 70)

var convertion: Dictionary = {
	'-': [Entry.NONE, 0],
	'A': [Entry.RED, 70]
}

func _make_pattern_from_str() -> void:
	pattern = Pattern.new()
	for c in pattern_str:
		pattern.append(convertion[c][0], convertion[c][1])

func _ready() -> void:
	_preload_all_resources()
	#_set_default_pattern()
	_make_pattern_from_str()
	pattern.set_direction(int(-transform.x.x))
	
func _preload_all_resources() -> void:
	for res: CarResource in resource_table:
		res.scene = load(res.path)


func _process(delta: float) -> void:
	counter += delta
	
	if counter > launch_rate:
		counter -= launch_rate
		_launch_car()


func _launch_car() -> void:
	var entry: Entry = pattern.get_next()
	if entry.type < Entry.NONE:
		var res: Resource = resource_table[entry.type].scene
		var car: Car = res.instantiate()
		get_parent().add_child(car)
		car.init(transform, launch_speed)
