extends Node

var _cardManager: CardManager;

# Called when the node enters the scene tree for the first time.
func _ready():
	var dashCardResource = preload("res://GameElements/Cards/DashCard/DashCard.tscn")
	var bombCardResource = preload("res://GameElements/Cards/BombCard/BombCard.tscn")
	
	 # CardManager is already a child of this scene, so we can just get it
	self._cardManager = self.get_node("CanvasLayer/Control/CardManager")
	print("CardManager found")
	
	# Load the cards
	print("Pushing card...")
	_cardManager.addCard(dashCardResource.instantiate())


	_cardManager.addCard(bombCardResource.instantiate())

	# Start the game
	_cardManager.start()

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
