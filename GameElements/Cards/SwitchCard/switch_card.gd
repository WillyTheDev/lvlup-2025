class_name SwitchCard
extends Card

@export var player : Node2D = null

func _ready():
	if player == null:
		var player = get_node("/root/Game/Map/Player")
	player.can_disable_laser = true

func apply_effect():
	if player == null:
		var player = get_node("/root/Game/Map/Player")
	player.disable_closest_switch_laser()
	player.can_disable_laser = false
	self.queue_free()
