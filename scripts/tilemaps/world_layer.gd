extends TileMapLayer

@onready var HGrassLayer := $HighGrassLayer

@onready var quarters_to_tile_source: Dictionary = {[0,1,0,0] : Vector2i(0,0),
											[0,0,1,1] : Vector2i(1,0),
											[1,1,0,1] : Vector2i(2,0),
											[0,1,0,1] : Vector2i(3,0),
											[1,0,0,1] : Vector2i(0,1),
											[0,1,1,1] : Vector2i(1,1),
											[1,1,1,1] : Vector2i(2,1),
											[1,1,1,0] : Vector2i(3,1),
											[0,0,1,0] : Vector2i(0,2),
											[1,0,1,0] : Vector2i(1,2),
											[1,0,1,1] : Vector2i(2,2),
											[1,1,0,0] : Vector2i(3,2),
											[0,0,0,1] : Vector2i(1,3),
											[0,1,1,0] : Vector2i(2,3),
											[1,0,0,0] : Vector2i(3,3),}

func _ready():
	var h_grass_cells := get_used_cells_by_id(0, Vector2i(0,0), 0)
	for cell_coord in h_grass_cells:
		placeVisualTile(cell_coord)

func placeVisualTile(cell_coord):
	for x: int in range(2):
		for y: int in range(2):
			var quarters: Array = getTileQuarters(cell_coord + Vector2i(x,y))
			var atlas_coord: Vector2i = quarters_to_tile_source.get(quarters)
			$HighGrassLayer.set_cell(cell_coord + Vector2i(x,y), 1, atlas_coord, 0)

func getTileQuarters(coord):
	var quarters := [0,0,0,0]
	var i := 0
	var neighbor := Vector2i(0,0)
	for x: int in range(2):
		for y: int in range(2):
			neighbor = get_cell_atlas_coords(coord - Vector2i(1,1) + Vector2i(x,y))
			if neighbor != Vector2i(-1,-1):
				quarters[i] = 1
			else:
				quarters[i] = 0
			i += 1
	return(quarters)
