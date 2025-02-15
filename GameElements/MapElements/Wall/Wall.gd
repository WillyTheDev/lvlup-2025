class_name Wall
extends Node

func set_outline(value):
	if value == true:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.WHITE)
		%CanvasGroup.material.set_shader_parameter("onoff",1.0)
	else:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.BLACK)
		%CanvasGroup.material.set_shader_parameter("onoff",0.0)

func destroys():
	const SMOKE = preload("res://GameElements/Smoke_explosion/smoke_explosion.tscn")
	var new_smoke = SMOKE.instantiate()
	new_smoke.global_position = self.global_position
	new_smoke.scale += Vector2(0.5,0.5)
	get_parent().add_child(new_smoke)
	self.queue_free()
