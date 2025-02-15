extends Node

var wall1_node: Node = null

func _ready():
	wall1_node = get_node("/root/Map/Walls/Wall1")

func _input(event):
	if event.is_action_pressed("use_card"):
		print("[input] use_card action key pressed")
		wall1_node.destroys()
