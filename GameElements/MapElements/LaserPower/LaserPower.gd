class_name Switch
extends Node

const OFF_TEXTURE = preload("res://Assets/LevelDesign/LaserPower_off.png")
const ON_TEXTURE = preload("res://Assets/LevelDesign/LaserPower_on.png")
const HOVER_TEXTURE = preload("res://Assets/LevelDesign/LaserPower_hover.png")

@export var laser_zone: Node = null

func set_outline(value):
	if value == true:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.WHITE)
		%CanvasGroup.material.set_shader_parameter("onoff",1.0)
		%CanvasGroup.get_node("Sprite").texture = HOVER_TEXTURE
	else:
		%CanvasGroup.material.set_shader_parameter("line_colour",Color.BLACK)
		%CanvasGroup.material.set_shader_parameter("onoff",0.0)
		%CanvasGroup.get_node("Sprite").texture = ON_TEXTURE

func disable_laser():
	%DeactivationAudioPlayer.play()
	set_outline(false)
	%CanvasGroup.get_node("Sprite").texture = OFF_TEXTURE
	laser_zone.area2d.set_collision_layer_value(1,false)
	laser_zone.area2d.set_collision_mask_value(1, false)
	get_node("/root/Game/Map/GameManager").on_next_round_started.connect(enable_enemy)
	# Changer sprite ici lorsque désactiver
	laser_zone.modulate = Color("ffffff00")
	%StaticBody2D.set_collision_layer_value(1,false)
	%StaticBody2D.set_collision_mask_value(1, false)

func enable_enemy():
	%CanvasGroup.get_node("Sprite").texture = ON_TEXTURE
	laser_zone.area2d.set_collision_layer_value(1,true)
	laser_zone.area2d.set_collision_mask_value(1, true)
	laser_zone.modulate = Color("ffffff")
	%StaticBody2D.set_collision_layer_value(1,true)
	%StaticBody2D.set_collision_mask_value(1, true)
