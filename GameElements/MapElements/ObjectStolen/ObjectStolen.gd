class_name Treasure
extends Node

var initial_z_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_z_index = %CanvasGroup.z_index
	get_node("/root/Game/Map/GameManager").on_next_round_started.connect(enable_enemy)

func set_outline(value):
	if value == true:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.WHITE)
		%CanvasGroup.material.set_shader_parameter("onoff",1.0)
		%CanvasGroup.z_index = initial_z_index + 2
	else:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.BLACK)
		%CanvasGroup.material.set_shader_parameter("onoff",0.0)
		%CanvasGroup.z_index = initial_z_index

func take():
	%StealAudioPlayer.play()
	self.visible = false
	%StaticBody2D.set_collision_layer_value(1,false)
	%StaticBody2D.set_collision_mask_value(1, false)

func enable_enemy():
	self.visible = true
	set_outline(false)
	%StaticBody2D.set_collision_layer_value(1,true)
	%StaticBody2D.set_collision_mask_value(1, true)
