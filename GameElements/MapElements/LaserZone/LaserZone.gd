extends Node


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		get_node("/root/Game/Map/GameManager").player_catch()
