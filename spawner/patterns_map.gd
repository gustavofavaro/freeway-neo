extends TileMapLayer
class_name PatternsMap

@export var spawners_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(spawners_node, name + ' spawners parent node must be set.')
	_extract_patterns_from_tilemap()


func _extract_patterns_from_tilemap() -> void:
		#get_cell_tile_data(0, Vector2.ZERO)
	var rect: Rect2 = get_used_rect()
	for y in range(rect.position.y, rect.end.x):
		#var strlog: String
		for x in range(rect.position.x, rect.end.x):
			var data: TileData = get_cell_tile_data(Vector2(x,y))
			if data:
				var type: int = data.get_custom_data("type")
				
				if type >= Spawner.Entry.SPAWN_RIGHT: # SPAWNER
					pass
				
				#strlog += str(data.get_custom_data("type")) + ' '
			#print(get_cell_atlas_coords(Vector2(x,y)))
		#print(strlog);
	#print(get_used_cells())
