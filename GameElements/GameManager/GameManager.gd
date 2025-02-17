class_name GameManager
extends Node

const SNEAK_MUSIC_FILE = preload("res://Assets/Music/Sneaky Steal in the House.mp3")

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
signal on_next_round_started
signal player_caught

func _ready():
	# Set the player in the card manager
	in_game_ui.cardManager.player = player
	get_tree().paused = true
	
func _process(_delta):
	if player_is_playing == true:
		var end_time = Time.get_ticks_msec()
		elapsed_time = float(end_time - start_time) / 1000.0

func player_catch():
	player_caught.emit
	%AudioStreamPlayer.stream = SNEAK_MUSIC_FILE
	%AudioStreamPlayer.play()
	get_tree().paused = true
	alert_layer.stop_layer()
	card_selection_layer.visible = true
	%PeekButtonLayer.visible = true
	player.player_camera.enabled = false
	in_game_ui.visible = false
	%BigCamera.enabled = true
	%CardSelectionLayer.visible = true
	%CardSelectionLayer.reset_selection()
	print("Player has been Catched !")

func on_treasure_get():
	alert_layer.show_layer()

func _on_card_selection_layer_on_next_pressed():
	# Unpause the game and update UI visibility
	get_tree().paused = false
	in_game_ui.visible = true
	card_selection_layer.visible = false
	%PeekButtonLayer.visible = false
	%CardSelectionLayer.visible = false

	# Reset player state and position
	player.global_position = player_spawn.global_position
	player.has_treasure = false
	player.can_stun = false
	player.can_destroy_wall = false
	player.can_get_treasure = false
	player.can_unlock_door = false
	player.can_disable_laser = false

	# Switch camera focus
	%BigCamera.enabled = false
	player.player_camera.enabled = true

	# Emit signal for next round
	on_next_round_started.emit()

	# Start card manager and set gameplay state
	in_game_ui.cardManager.start()
	player_is_playing = true
	start_time = Time.get_ticks_msec()

	# Log UI and card manager state
	print(in_game_ui)
	print(in_game_ui.cardManager)

func player_has_finished():
	player_is_playing = false
	get_tree().paused = true
	var end_time = Time.get_ticks_msec()
	elapsed_time = float(end_time - start_time) / 1000.0
	%VictoryLayer.visible = true
	$"../../VictoryLayer/MarginContainer/VBoxContainer/Time Label".text = "[center]" + str(elapsed_time) + " seconds"

func _on_peek_button_pressed():
	card_selection_layer.visible = !card_selection_layer.visible
