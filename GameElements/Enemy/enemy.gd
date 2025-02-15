extends CharacterBody2D
@export var enemy_speed := 0
var target : Node2D = null
var normalized = 1
func _ready():
	if get_parent() is PathFollow2D:
		normalized = 1
	else:
		normalized = -1

func _physics_process(delta):
	if target != null:
		var direction = (global_position - target.global_position).normalized() * normalized
		position += delta * enemy_speed * direction


func _on_taunt_area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		if get_parent() is PathFollow2D:
			get_parent().path_speed = 0


func _on_catch_area_body_entered(body):
	if body.is_in_group("Player"):
		get_node("/root/Map/GameManager").player_catch()
