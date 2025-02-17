class_name StunCard
extends Card

@export var player : Node2D = null

func _ready():
	if player == null:
		player = get_node("/root/Game/Map/Player")
	player.can_stun = true

func apply_effect():
	if player == null:
		player = get_node("/root/Game/Map/Player")
	player.stun_closest_enemy()
	player.can_stun = false
	queue_free()
	
