# Manage the card stack of the game (the cards chosen by the player)
class_name CardManager
# Allows this to be placed in the scene and interact with the scene
extends Node

var _cardStack: Array[Card]
var _inGame: bool
@export var player: Node2D = null

# Init the manager
func _init():
	self._cardStack = []
	self._inGame = false

# Called when the node enters the scene tree for the first time.
func start():
	# Don't start the manager if the stack is empty
	if _isStackEmpty():
		return
	# Set the in game flag to true
	self._inGame = true
	# Display the top card
	_displayCurrentCard()

func stop():
	 # Set the in game flag to false
	self._inGame = false
	# If the stack is empty, just return
	if _isStackEmpty():
		return
	# Otherwise, remove the current card from the scene, but keep it in the stack
	_getCurrentCard().queue_free()

func reset():
	# Reset the game state
	self._inGame = false
	# If the stack is empty, just return
	if _isStackEmpty():
		return
	# Remove the current card from the scene
	_removeCurrentCard()
	# Clear the stack
	clearStack()

func clearStack():
	self._cardStack.clear()

# Push a card to the stack
# @param card: Card to be pushed
func addCard(card: Card):
	if player != null:
		card.player = self.player
	self._cardStack.push_back(card)

# Remove the current card and go to the next one
func _nextCard():
	# Don't allow the player to play if the game is not in progress
	if !self._inGame:
		return
	# If the stack is empty, stop the manager
	if _isStackEmpty():
		stop()
		return
	# Remove the current card
	_removeCurrentCard()
	# Display the next current card
	_displayCurrentCard()

# Display the top card of the stack
func _displayCurrentCard():
	# If the stack is empty, stop the manager (shouldn't happen here)
	if _isStackEmpty():
		stop()
		return
	# First, get the current card 
	var card: Card = _getCurrentCard()
	# Then, get the card position node
	var cardPosition = %CardPosition
	# Display the card by adding it to the node
	cardPosition.add_child(card)
	# Finally, subscribe to the card's signal
	card.card_has_been_used.connect(_nextCard)

# Remove the current card from the scene and the stack
func _removeCurrentCard():
	# If the stack is empty, stop the manager (shouldn't happen here)
	if _isStackEmpty():
		return
	self._cardStack.pop_front().queue_free()

# Get the current card (without removing it from the stack)
func _getCurrentCard():
	return self._cardStack.front()

# Return whether the stack is empty or not
func _isStackEmpty():
	return self._cardStack.is_empty()
