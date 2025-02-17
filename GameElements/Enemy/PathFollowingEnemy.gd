extends PathFollow2D

@export var path_speed = 0.3
var direction = 1

func _process(delta):
	progress_ratio += path_speed * direction * delta
	if direction == 1 and progress_ratio > 0.95:
		direction = -1
	if direction == -1 and progress_ratio < 0.05:
		direction = 1
