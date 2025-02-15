class_name DashCard
extends Card

func _ready():
	pass

func apply_effect():
	get_node("/root/Game/Map/Player").dash()
