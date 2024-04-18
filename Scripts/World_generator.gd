extends Node2D

@export var noise_texture : NoiseTexture2D
@onready var map: = $TileMap

var noise : Noise

var width : int = 300
var height : int = 300

var dirt_arr: = []
var dirt_id: = 2
var dirt_tile: = Vector2i(1,1)
var dirt_layer: = 2

var water_id = 3
var water_tile: = Vector2i(0,0)
var water_layer: = 3

var hill_arr: = []
var hill_id: = 1
var hill_layer: = 1
var set_hill: = 1

var grass_arr: = []
var grass_id: = 0
var grass_layer: = 0
var set_grass: = 0
var rng = RandomNumberGenerator.new()
var rng_num = 0

func _ready():
	randomize()
	var rng_num = rng.randf_range(0, 20.0)
	noise_texture.noise.set_seed(rng_num)
	noise = noise_texture.noise
	generate_world()
	
func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			
			if noise_val > 0.3:
			
				hill_arr.append(Vector2i(x,y))
				
			elif noise_val >= 0.1:
				grass_arr.append(Vector2i(x,y))
				
			elif noise_val >= 0.0:
				
				map.set_cell(dirt_layer, Vector2(x,y), dirt_id, dirt_tile)
			map.set_cell(water_layer, Vector2(x,y), water_id, water_tile)
	map.set_cells_terrain_connect(hill_layer, hill_arr, set_hill,0)
	map.set_cells_terrain_connect(grass_layer, grass_arr, set_grass,0)
