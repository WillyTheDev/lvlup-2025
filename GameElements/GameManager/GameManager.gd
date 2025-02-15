class_name GameManager
extends Node

@export var player : Node2D = null
@export var card_selection_layer : CanvasLayer = null
@export var player_spawn : Node2D = null
@export var map : Node2D = null
@export var alert_layer: CanvasLayer = null
@export var in_game_ui: CanvasLayer
@export var victory_layer : CanvasLayer = null

var player_is_playing = false
var start_time = 0
var elapsed_time = 0
signal player_has_been_catched
signal on_next_round_started

func _ready():
	# Set the player in the card manager
	in_game_ui.cardManager.player = player
	get_tree().paused = true
	
func _process(delta):
	if player_is_playing == true:
		var end_time = Time.get_ticks_msec()
		elapsed_time = float(end_time - start_time) / 1000.0

func player_catch():
	get_tree().paused = true
	alert_layer.stop_layer()
	player_has_been_catched.emit()
	card_selection_layer.visible = true
	player.player_camera.enabled = false
	in_game_ui.visible = false
	%BigCamera.enabled = true
	%CardSelectionLayer.visible = true
	%CardSelectionLayer.reset_selection()
	print("Player has been Catched !")

func on_treasure_get():
	alert_layer.show_layer()

func _on_card_selection_layer_on_next_pressed():
	get_tree().paused = false
	in_game_ui.visible = true
	on_next_round_started.emit()
	card_selection_layer.visible = false
	player.global_position = player_spawn.global_position
	player.has_treasure = false
	%BigCamera.enabled = false
	player.player_camera.enabled = true
	%CardSelectionLayer.visible = false
	# Make the in game UI visible
	print(in_game_ui)
	in_game_ui.visible = true
	# Start the card manager
	print(in_game_ui.cardManager)
	in_game_ui.cardManager.start()
	player_is_playing = true
	start_time = Time.get_ticks_msec()

func player_has_finished():
	player_is_playing = false
	get_tree().paused = true
	var end_time = Time.get_ticks_msec()
	elapsed_time = float(end_time - start_time) / 1000.0
	%VictoryLayer.visible = true
	$"../../VictoryLayer/MarginContainer/VBoxContainer/Time Label".text = "[center]" + str(elapsed_time) + " seconds"
