# Manage the card stack of the game (the cards chosen by the player)
class_name CardManager
# Allows this to be placed in the scene and interact with the scene
extends Node

var _cardStack: Array[Card]

# Init the manager
func _init():
	self._cardStack = []

# Push a card to the stack
# @param card: Card to be pushed
func pushCard(card: Card):
	self._cardStack.push_back(card)
	# Instanciate the card in this CardManager scene
	self.add_child(card)
	# Don't show the card until the game begins?
	# TODO:

# Remove the current card and go to the next one
func nextCard():
	var card: Card = self._cardStack.pop_back()
	# Method of Node to remove it from a scene
	card.queue_free()
	# Instanciate the next card and subscribe to the signal
	var newCard: Card = self._cardStack.back()
	newCard.card_has_been_used.connect(nextCard())
	# Show card
	# TODO: Check if this works
	# newCard.show()
	
# Clear the stack (used when there is a game over or reload)
# TODO: Check if this is necessary
func clearStack():
	self._cardStack.clear()
