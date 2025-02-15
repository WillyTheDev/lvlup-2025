class_name BombCard
extends Card

@export var player : Node2D = null

func _ready():
	if player == null:
		player = get_node("/root/Game/Map/Player")
	player.can_destroy_wall = true

func apply_effect():
	if player == null:
		player = get_node("/root/Game/Map/Player")
	player.destroy_closest_wall()
	player.can_destroy_wall = false
	self.queue_free()
