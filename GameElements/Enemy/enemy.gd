class_name Enemy
extends CharacterBody2D

@export var enemy_speed := 0

var target : Node2D = null
var normalized = 1
var starting_position : Vector2
var initial_parent_speed = 0
var initial_z_index = 0

func _ready():
	set_outline(false)
	starting_position = self.global_position
	initial_z_index = %CanvasGroup.z_index
	if get_parent() is PathFollow2D:
		initial_parent_speed = get_parent().path_speed
	get_node("/root/Game/Map/GameManager").on_next_round_started.connect(enable_enemy)

func _physics_process(delta):
	if target != null:
		var direction = (global_position - target.global_position).normalized() * normalized * -1
		velocity = enemy_speed * direction
		move_and_slide()
		if velocity.length() > 0.0:
			play_animation_walk()
		else:
			play_animation_idle()

func set_outline(value):
	if value == true:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.WHITE)
		%CanvasGroup.material.set_shader_parameter("onoff",1.0)
		%CanvasGroup.z_index = initial_z_index + 2
	else:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.BLACK)
		%CanvasGroup.material.set_shader_parameter("onoff",0.0)
		%CanvasGroup.z_index = initial_z_index

func _on_taunt_area_body_entered(body):
	if body.is_in_group("Player"):
		if self.visible:
			%ChaseAudioPlayer.play()
		target = body
		if get_parent() is PathFollow2D:
			get_parent().path_speed = 0

func _on_catch_area_body_entered(body):
	if body.is_in_group("Player"):
		get_node("/root/Game/Map/GameManager").player_catch()
		target = null
		
func stun():
	%StunAudioPlayer.play()
	%ChaseAudioPlayer.stop()
	const SMOKE = preload("res://GameElements/Smoke_explosion/smoke_explosion.tscn")
	var new_smoke = SMOKE.instantiate()
	new_smoke.global_position = self.global_position
	new_smoke.scale += Vector2(0.5,0.5)
	get_node("/root/Game/Map").add_child(new_smoke)
	self.visible = false
	self.set_collision_layer_value(1,false)
	self.set_collision_mask_value(1, false)
	%CatchArea.set_collision_layer_value(1, false)
	%CatchArea.set_collision_mask_value(1, false)
	
func enable_enemy():
	target = null
	self.global_position = starting_position
	self.visible = true
	self.set_collision_layer_value(1,true)
	self.set_collision_mask_value(1, true)
	%CatchArea.set_collision_layer_value(1, true)
	%CatchArea.set_collision_mask_value(1, true)
	set_outline(false)
	if get_parent() is PathFollow2D:
		get_parent().path_speed = initial_parent_speed
		get_parent().progress_ratio = 0
		get_parent().direction = 1
	
	
func play_animation_idle():
	%AnimationPlayer.play("idle")
	
func play_animation_walk():
	%AnimationPlayer.play("walk")
