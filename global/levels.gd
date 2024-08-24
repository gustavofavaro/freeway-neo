extends Node
class_name CLevels

# Place to store all levels cars patterns
var level: int = 1

func get_level_pattern(game_level: int):
	# level 1 -> index 0
	game_level -= 1  
	
	if game_level >= len(patterns):
		return []
	
	#var pattern: Array[Spawner]
	
	return patterns[game_level]

# LEVEL 1
# 	4 ->
# 	7 <-
const patterns = [
[
	
# VAI FICAR MUITO MELHOR DESENHAR COMO TILE MAP E DEPOIS PEGAR AS POSIÇÕES DOS TILES
'A----A----', # >>
'-A----A---', # >>
'--A----A--', # >>
'---A----A-', # >>

'A-A-AAA-AAA-AAA--A', # <<
'A-A--A--A---A-A--A', # <<
'A-A--A--A---A-A--A', # <<
'A-A--A--AA--AAA--A', # <<
'A-A--A--A---A----A', # <<
'A-A--A--A---A----A', # <<
'AAA--A--A---A----A'  # <<
]
]
