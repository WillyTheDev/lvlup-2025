class_name DashCard
extends Card

func _ready():
	pass

func apply_effect():
	get_node("/root/Map/Player/CharacterBody2D").dash()
