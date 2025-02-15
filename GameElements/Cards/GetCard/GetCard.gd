class_name GetCard
extends Card

@export var player : Node2D = null

func _ready():
	if player == null:
		var player = get_node("/root/Game/Map/Player")
	player.can_get_treasure = true

func apply_effect():
	if player == null:
		var player = get_node("/root/Game/Map/Player")
	player.get_treasure()
	player.can_get_treasure = false
	self.queue_free()
