class_name GameManager
extends Node

@export var player : Node2D = null
@export var card_selection_layer : CanvasLayer = null
@export var player_spawn : Node2D = null
@export var map : Node2D = null
@onready var player_scene : Node2D = preload("res://GameElements/Player/Player.tscn").instantiate()

signal player_has_been_catched

func player_catch():
	player_has_been_catched.emit()
	card_selection_layer.visible = true
	%BigCamera.enabled = true
	print("Player has been Catched !")
	

func _on_execute_pressed():
	card_selection_layer.visible = false
	player_scene.global_position = player_spawn.global_position
	player_scene.game_manager = self
	player_scene.player_speed = 400
	player_scene.dash_speed = 1000
	%BigCamera.enabled = false
	map.add_child(player_scene)
