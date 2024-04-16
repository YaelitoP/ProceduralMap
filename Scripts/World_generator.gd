extends Node2D

@export var noise_texture : NoiseTexture2D
@onready var map: = $TileMap
var noise : Noise

var width : int = 100
var height : int = 100

var dirt_id: = 4
var dirt_tile: = Vector2i(1,1)

var hill_id: = 3
var hill_tile: = Vector2i(1,2)

var grass_id: = 2
var grass_tile: = Vector2i(1,1)


func _ready():
	noise = noise_texture.noise
	generate_world()
	
func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			if noise_val > 0.3:
				map.set_cell(0, Vector2(x,y), hill_id, hill_tile)
			elif noise_val >= 0.0:
				map.set_cell(0, Vector2(x,y), grass_id, grass_tile)
			elif noise_val < 0.0:
				map.set_cell(0, Vector2(x,y), dirt_id, dirt_tile)

