class_name Card
extends Node

var identifier: String
var texture_normal: Texture2D
var texture_hover: Texture2D
var texture_pressed: Texture2D
var Scene:Resource

signal card_has_been_used

func _initI(id, card_texture_normal, card_texture_hover, card_texture_pressed, card_scene):
	self.identifier = id
	self.texture_normal = card_texture_normal
	self.texture_hover = card_texture_hover
	self.texture_pressed = card_texture_pressed
	self.scene = card_scene

func _input(event):
	if event.is_action_pressed("use_card"):
		apply_effect()
		card_has_been_used.emit()
		
		
func apply_effect():
	pass
