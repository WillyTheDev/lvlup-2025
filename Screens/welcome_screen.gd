extends Node2D

func _on_play_button_pressed():
	$TransitionLayer.close_transition()
	
func _on_transition_layer_transition_is_finished(anim_name):
	get_tree().change_scene_to_file("res://Screens/GameScreen.tscn")
