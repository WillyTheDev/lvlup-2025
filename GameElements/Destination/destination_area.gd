extends Area2D


func _on_body_entered(body):
	if body is Player && body.has_treasure:
		get_node("/root/Game/Map/GameManager").player_has_finished()
