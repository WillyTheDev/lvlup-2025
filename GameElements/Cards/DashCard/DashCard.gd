class_name DashCard
extends Card

func apply_effect():
	get_node("/root/Map/Player/CharacterBody2D").dash()
