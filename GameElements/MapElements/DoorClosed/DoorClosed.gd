class_name Door
extends Node

var tween: Tween
var progess = 100
	
func set_outline(value):
	if value == true:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.WHITE)
		%CanvasGroup.material.set_shader_parameter("onoff",1.0)
		%CanvasGroup.z_index += 1
	else:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.BLACK)
		%CanvasGroup.material.set_shader_parameter("onoff",0.0)
		%CanvasGroup.z_index -= 1
	
func unlock_door():
	%UnlockAudioPlayer.play()
	get_node("/root/Game/Map/GameManager").on_next_round_started.connect(enable_enemy)
	self.visible = false
	%StaticBody2D.set_collision_layer_value(1,false)
	%StaticBody2D.set_collision_mask_value(1, false)

func enable_enemy():
	self.visible = true
	%StaticBody2D.set_collision_layer_value(1,true)
	%StaticBody2D.set_collision_mask_value(1, true)
