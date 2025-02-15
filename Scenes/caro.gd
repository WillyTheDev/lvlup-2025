extends Node

var _cardManager: CardManager;

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardManagerResource = preload("res://GameElements/CardsManager/CardManager.tscn")
	var dashCardResource = preload("res://GameElements/Cards/DashCard/DashCard.tscn")
	
	# Instanciate the CardManager
	_cardManager = cardManagerResource.instantiate();
	# Add the CardManager to the scene
	add_child(_cardManager)
	# Load the cards
	_cardManager.pushCard(dashCardResource.instantiate())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
