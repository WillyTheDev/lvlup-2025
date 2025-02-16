extends Node2D

var selectedLevel: int = 1

func _ready():
	# Pre-select default level
	toggle(selectedLevel)

func _on_play_button_pressed():
	$TransitionLayer.close_transition()
	
func _on_transition_layer_transition_is_finished(_anim_name):
	if selectedLevel == 1:
		get_tree().change_scene_to_file("res://Screens/Level1/GameScreen.tscn")
	elif selectedLevel == 2:
		get_tree().change_scene_to_file("res://Screens/Level2/GameScreen.tscn")
	elif selectedLevel == 3:
		get_tree().change_scene_to_file("res://Screens/Level3/GameScreen.tscn")

func _on_button_1_pressed():
	toggle(selectedLevel)
	selectedLevel = 1
	toggle(selectedLevel)

func _on_button_2_pressed():
	toggle(selectedLevel)
	selectedLevel = 2
	toggle(selectedLevel)

func _on_button_3_pressed():
	toggle(selectedLevel)
	selectedLevel = 3
	toggle(selectedLevel)

func toggle(index: int):
	var myButton = null
	if index == 1:
		myButton = %Button1
	elif index == 2:
		myButton = %Button2
	elif index == 3:
		myButton = %Button3
	
	if myButton != null:
		myButton.disabled = !myButton.disabled
