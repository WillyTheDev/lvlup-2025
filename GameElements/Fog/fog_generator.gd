extends Node2D
@export var MAP_SIZE_X = 1000
@export var MAP_SIZE_Y = 1000
const FOG_SIZE = 100

func _ready():
	var position_to_instantiate = Vector2(0,0)
	while position_to_instantiate.y < MAP_SIZE_Y:
		while position_to_instantiate.x < MAP_SIZE_X:
			var fog = preload("res://GameElements/Fog/Fog.tscn").instantiate()
			fog.name = "Fog"
			add_child.call_deferred(fog)
			position_to_instantiate.x += FOG_SIZE
			fog.position = position_to_instantiate
		position_to_instantiate.y += FOG_SIZE
		position_to_instantiate.x = 0
