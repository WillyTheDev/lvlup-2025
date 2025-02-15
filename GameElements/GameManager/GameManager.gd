class_name GameManager
extends Node

@export var player : Node2D = null
@export var card_selection_layer : CanvasLayer = null
@export var player_spawn : Node2D = null
@export var map : Node2D = null


signal player_has_been_catched
signal on_next_round_started
func _ready():
	get_tree().paused = true

func player_catch():
	player_has_been_catched.emit()
	card_selection_layer.visible = true
	%BigCamera.enabled = true
	%CardSelectionLayer.visible = true
	%CardSelectionLayer.reset_selection()
	print("Player has been Catched !")


func _on_execute_pressed():
	get_tree().paused = false
	const player_scene = preload("res://GameElements/Player/Player.tscn")
	var new_player = player_scene.instantiate()
	card_selection_layer.visible = false
	new_player.global_position = player_spawn.global_position
	new_player.game_manager = self
	new_player.player_speed = 400
	new_player.dash_speed = 1000
	%BigCamera.enabled = false
	%CardSelectionLayer.visible = false
	map.add_child(new_player)
