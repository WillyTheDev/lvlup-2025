class_name Enemy
extends CharacterBody2D


@export var enemy_speed := 0

var target : Node2D = null
var normalized = 1

func _ready():
	if get_parent() is PathFollow2D:
		print("Parent is PathFollow2D")
		normalized = -1
	else:
		normalized = -1
	set_outline(false)

func _physics_process(delta):
	if target != null:
		var direction = (global_position - target.global_position).normalized() * normalized
		position += delta * enemy_speed * direction

func set_outline(value):
	if value == true:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.WHITE)
		%CanvasGroup.material.set_shader_parameter("onoff",1.0)
	else:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.BLACK)
		%CanvasGroup.material.set_shader_parameter("onoff",0.0)

func _on_taunt_area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		if get_parent() is PathFollow2D:
			get_parent().path_speed = 0

func _on_catch_area_body_entered(body):
	if body.is_in_group("Player"):
		get_node("/root/Game/Map/GameManager").player_catch()
		
func stun():
	get_node("/root/Game/Map/GameManager").on_next_round_started.connect(enable_enemy)
	self.visible = false
	
func enable_enemy():
	self.visible = true
