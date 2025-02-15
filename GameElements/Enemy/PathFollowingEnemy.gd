extends PathFollow2D

@export var path_speed := 0.1

func _process(delta):
	if progress_ratio <= 1:
		progress_ratio += path_speed
	else:
		progress_ratio -= path_speed
