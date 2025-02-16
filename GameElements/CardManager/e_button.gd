extends Node2D

const ACTIVE_TEXTURE = preload("res://Assets/UI/buttonE_active.png")
const NEUTRAL_TEXTURE = preload("res://Assets/UI/buttonE_neutral.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("use_card"):
		self.get_node("Front").texture = ACTIVE_TEXTURE
	
	if Input.is_action_just_released("use_card"):
		self.get_node("Front").texture = NEUTRAL_TEXTURE
