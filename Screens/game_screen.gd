extends Node2D

func _ready():
	$TransitionLayer.open_transition()

func _on_retry_game_button_pressed():
	print("pressed")
	get_tree().change_scene_to_file("res://Screens/WelcomeScreen.tscn")
