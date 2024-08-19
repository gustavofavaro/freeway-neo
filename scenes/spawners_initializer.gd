extends Node2D
class_name SpawnersInitializer

# Initializes all nested nodes of class Spawner
func _ready() -> void:
	var patterns = Levels.get_level_pattern(Levels.level)
	
	# Injects the 'pattern' attribute into all nested spawners
	var idx: int = 0
	for spw: Spawner in get_children():
		spw.pattern = patterns[idx]
		idx += 1
		
		# make sure the array has enough patterns
		if idx == len(patterns): 
			break
