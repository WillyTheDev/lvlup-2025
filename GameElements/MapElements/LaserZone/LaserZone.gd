extends Node

var gamemanager: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gamemanager = get_node("/root/GameManager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		print("playercatch")
