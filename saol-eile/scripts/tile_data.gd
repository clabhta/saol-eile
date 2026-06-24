extends Node

@onready var terrain = $terrain

var walkable = {}

func _ready():
	generate_tiles()

func generate_tiles():
	for z in range(terrain.height):
		for x in range(terrain.width):
			walkable[Vector2i(x, z)] = true
