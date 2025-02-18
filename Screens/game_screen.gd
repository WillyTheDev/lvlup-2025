extends Node2D

func _ready():
	$TransitionLayer.open_transition()

func _on_retry_game_button_pressed():
	%VictoryLayer.visible = false
	%GameManager.player_catch()

func _on_menu_game_button_pressed():
	get_tree().change_scene_to_file("res://Screens/WelcomeScreen.tscn")
