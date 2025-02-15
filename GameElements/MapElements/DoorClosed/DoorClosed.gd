class_name Door
extends Node

var tween: Tween
var progess = 100
	
func set_outline(value):
	if value == true:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.WHITE)
		%CanvasGroup.material.set_shader_parameter("onoff",1.0)
	else:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.BLACK)
		%CanvasGroup.material.set_shader_parameter("onoff",0.0)
	
func unlock_door():
	if tween:
		tween.stop
	tween = create_tween()
	tween.tween_property(self, "progress", 0, 3)
	tween.finished.connect(_remove_door)

func _remove_door():
	self.queue_free()
