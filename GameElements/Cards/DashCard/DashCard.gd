class_name DashCard
extends Card

var player : Node2D = null

func _ready():
	if player == null:
		var player = get_node("/root/Game/Map/Player")

func apply_effect():
	player.dash()
	self.queue_free()
