extends Node2D

func _on_area_2d_body_entered(body):
	print("Body entered !")
	if body.is_in_group("Player"):
		queue_free()
