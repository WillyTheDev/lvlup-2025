extends Node

func _input(event):
	# if event is ui_cancel
	if event.is_action_pressed("ui_cancel"):

		# # Delete current animation
		# var transitionLayer = get_node("/root/Game/TransitionLayer")
		# if transitionLayer != null:
		# 	transitionLayer.visible = false
		# 	var transitionPlayer = transitionLayer.get_node("TransitionPlayer")
		# 	if transitionPlayer != null:
		# 		transitionPlayer.stop()

		# Go to welcome screen
		get_tree().change_scene_to_file("res://Screens/WelcomeScreen.tscn")
		print("Escape key pressed !")
