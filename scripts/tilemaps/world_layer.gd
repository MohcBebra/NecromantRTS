extends TileMapLayer

@onready var visual_layers: Array[Node] = self.get_children()

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
	var m_grass_cells := self.get_used_cells_by_id(0, Vector2i(0,0), 0)
	var h_grass_cells := self.get_used_cells_by_id(0, Vector2i(1,0), 0)
	var l_grass_cells := self.get_used_cells_by_id(0, Vector2i(2,0), 0)
	if m_grass_cells != []:
		for cell_coord in m_grass_cells:
			place_visual_tile(cell_coord, visual_layers[0], Vector2i(0,0))
	if h_grass_cells != []:
		for cell_coord in h_grass_cells:
			place_visual_tile(cell_coord, visual_layers[1], Vector2i(1,0))

func place_visual_tile(cell_coord: Vector2i, visual_layer: TileMapLayer, world_tile_atlas_coord: Vector2i):
	for x: int in range(2):
		for y: int in range(2):
			var quarters: Array = get_tile_quarters(cell_coord + Vector2i(x,y), world_tile_atlas_coord)
			var atlas_coord: Vector2i = quarters_to_tile_source.get(quarters)
			visual_layer.set_cell(cell_coord + Vector2i(x,y), 0, atlas_coord, 0)

func get_tile_quarters(coord: Vector2i, world_tile_atlas_coord):
	var quarters := [0,0,0,0]
	var i := 0
	var neighbor := Vector2i(0,0)
	for x: int in range(2):
		for y: int in range(2):
			neighbor = self.get_cell_atlas_coords(coord - Vector2i(1,1) + Vector2i(x,y))
			if neighbor == world_tile_atlas_coord:
				quarters[i] = 1
			else:
				quarters[i] = 0
			i += 1
	return(quarters)
