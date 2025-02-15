# Manage the card stack of the game (the cards chosen by the player)
class_name CardManager
# Allows this to be placed in the scene and interact with the scene
extends Node

var _cardStack: Array[Card]
var _inGame: bool

# Init the manager
func _init():
	self._cardStack = []
	self._inGame = false

# Called when the node enters the scene tree for the first time.
func start():
	self._inGame = true
	# Display the top card
	displayTopCard()

func stop():
	self._inGame = false
	# Remove the last card from the scene, but keep in the stack
	var card = self._cardStack.back()
	if card != null:
		card.queue_free()

func reset():
	# Reset the game state
	self._inGame = false
	# Remove the last card from the scene
	var card = self._cardStack.back()
	card.queue_free()
	# Clear the stack
	self._cardStack.clear()

# Push a card to the stack
# @param card: Card to be pushed
func pushCard(card: Card):
	self._cardStack.push_back(card)

# Remove the current card and go to the next one
func nextCard():
	# Don't allow the player to play if the game is not in progress
	if !self._inGame:
		return
	var card: Card = self._cardStack.pop_back()
	if card == null:
		stop()
		return
	# Method of Node to remove it from a scene
	card.queue_free() # TODO: Try card.free if having issues
	# Display the next card
	displayTopCard()

func displayTopCard():
	# First, get the top card
	var card: Card = self._cardStack.back()
	if card == null:
		stop()
		return
	# Then, get the card position node
	var cardPosition = %CardPosition
	# Display the card by adding it to the node
	cardPosition.add_child(card)
	# Finally, subscribe to the card's signal
	card.card_has_been_used.connect(nextCard)
	
# Clear the stack (used when there is a game over or reload)
# TODO: Check if this is necessary
func clearStack():
	self._cardStack.clear()
