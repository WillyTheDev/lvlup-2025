class_name GameManager
extends Node

@export var player : Node2D = null
@export var card_selection_layer : CanvasLayer = null
@export var player_spawn : Node2D = null
@export var map : Node2D = null
@export var alert_layer: CanvasLayer = null


signal player_has_been_catched
signal on_next_round_started

func _ready():
	get_tree().paused = true

func player_catch():
	get_tree().paused = true
	alert_layer.stop_layer()
	player_has_been_catched.emit()
	card_selection_layer.visible = true
	player.player_camera.enabled = false
	%BigCamera.enabled = true
	%CardSelectionLayer.visible = true
	%CardSelectionLayer.reset_selection()
	print("Player has been Catched !")

func on_treasure_get():
	alert_layer.show_layer()

func _on_card_selection_layer_on_next_pressed():
	get_tree().paused = false
	card_selection_layer.visible = false
	player.global_position = player_spawn.global_position
	%BigCamera.enabled = false
	player.player_camera.enabled = true
	%CardSelectionLayer.visible = false
	# Start the card manager
	%CardManager.start()
