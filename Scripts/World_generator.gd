extends Node2D

@export var noise_texture : NoiseTexture2D
@export var noise_tree: NoiseTexture2D
@onready var map: = $TileMap
@onready var camera: = $Camera2D
var noise : Noise
var noiseT : Noise
var width : int = 200
var height : int = 200

#use it for experiments with news sources
var source_id: = 0


var dirt_arr: = []
var set_dirt: = 2
var dirt_layer: = 2


var set_water: = 3
var water_arr: = []
var water_layer: = 3

var hill_arr: = []
var hill_layer: = 1
var set_hill: = 1

var grass_arr: = []
var grass_layer: = 0
var set_grass: = 0

var tree_id: = 7
var tree_pos: = Vector2i(0,0)
var tree_layer: = 4



var val_arr: = []
var rng = RandomNumberGenerator.new()
var rng_num = 0

func _ready():
	randomize()
	rng_num = rng.randf_range(0, 10.0)
	noise_texture.noise.set_seed(rng_num)
	noise = noise_texture.noise
	noiseT = noise_tree.noise
	generate_world()

func _physics_process(delta):
	if Input.is_action_just_pressed("zoomIn"):
		camera.set_zoom(Vector2(camera.get_zoom().x + 0.1, camera.get_zoom().y + 0.1))
	
	if Input.is_action_just_pressed("zoomOut"):
		camera.set_zoom(Vector2(camera.get_zoom().x - 0.1, camera.get_zoom().y - 0.1))
		
func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			var noiseT_val = noiseT.get_noise_2d(x,y)
			val_arr.append(noiseT_val)
			
			if noise_val >= -0.2 and noise_val <= 0.1:
				dirt_arr.append(Vector2i(x,y))
			
			elif noise_val > 0.1:
				grass_arr.append(Vector2i(x,y))
				if noiseT_val > 0.7 and noise_val <= 0.4:
					map.set_cell(tree_layer,Vector2i(x,y), tree_id, tree_pos)
			elif noise_val > 0.5:
				hill_arr.append(Vector2i(x,y))
				
				
			water_arr.append(Vector2i(x,y))
			
	map.set_cells_terrain_connect(water_layer, water_arr, source_id, set_water)
	map.set_cells_terrain_connect(dirt_layer, dirt_arr, source_id, set_dirt)
	map.set_cells_terrain_connect(grass_layer, grass_arr, source_id, set_grass)
	map.set_cells_terrain_connect(hill_layer, hill_arr, source_id, set_hill)
	print(val_arr.max(),"  ",val_arr.min())


