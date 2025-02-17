class_name DoorCard
extends Card

@export var player : Node2D = null

func _ready():
	if player == null:
		player = get_node("/root/Game/Map/Player")
	player.can_unlock_door = true

func apply_effect():
	if player == null:
		player = get_node("/root/Game/Map/Player")
	player.open_closest_door()
	player.can_unlock_door = false
	self.queue_free()
