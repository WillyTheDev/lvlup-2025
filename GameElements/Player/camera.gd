extends Camera2D


@export var shakeFade : float = 5.0

var rnd = RandomNumberGenerator.new()
var speed = 300
var shake_strength: float = 0
var move_camera_toward_core = false
var initial_position : Vector2 = Vector2(0,0)
var target : Vector2 = Vector2(0,0)

func _ready():
	get_parent().game_manager._player_has_been_catched.connect(show_entire_map)
	
func show_entire_map():
	print("Camera Show Map")
	
func apply_shake(strength, emitter_position: Vector2):
	shake_strength = strength * (-0.0025 * (global_position.distance_to(emitter_position)) + 1)

func random_offset() -> Vector2:
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
	
func _process(delta):
	if move_camera_toward_core:
		global_position = global_position.lerp(target, delta * 2)
	else:
		var mouse_offset = get_viewport().get_mouse_position() - Vector2(get_viewport().size / 2)
		position = lerp(Vector2(), mouse_offset.normalized() * 300, mouse_offset.length() / 1000)
		if shake_strength > 0:
			shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
			offset = random_offset()
