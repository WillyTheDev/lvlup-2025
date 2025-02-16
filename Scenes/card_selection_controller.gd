extends CanvasLayer

@export var maximum_amount_of_card := 5
@export var in_game_ui: CanvasLayer
var number_of_selected_card = 0

const STUN_CARD = preload("res://GameElements/Cards/StunCard/StunCard.tscn")
const DASH_CARD = preload("res://GameElements/Cards/DashCard/DashCard.tscn")
const GET_CARD = preload("res://GameElements/Cards/GetCard/GetCard.tscn")
const BOMB_CARD = preload("res://GameElements/Cards/BombCard/BombCard.tscn")
const LASER_CARD = preload("res://GameElements/Cards/SwitchCard/SwitchCard.tscn")
const DOOR_CARD = preload("res://GameElements/Cards/DoorCard/DoorCard.tscn")
const SELECTED_CARD = preload("res://UI/SelectedCard/selected_card.tscn")

signal on_next_pressed

func _ready():
	var text = " (max " + str(maximum_amount_of_card) + ")"
	%SelectedCardsText.text += text

func add_card_to_selected_list(card: Card):
	if number_of_selected_card < maximum_amount_of_card:
		number_of_selected_card += 1
		var new_card = SELECTED_CARD.instantiate()
		new_card.texture_normal = card.texture
		%SelectedCardList.add_child(new_card)
		in_game_ui.cardManager.addCard(card)

func reset_selection():
	number_of_selected_card = 0
	for child in %SelectedCardList.get_children():
		%SelectedCardList.remove_child(child)
		in_game_ui.cardManager.reset()

func _on_stun_card_button_pressed():
	add_card_to_selected_list(STUN_CARD.instantiate())
	# add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/StunCardButton.texture_normal)


func _on_dash_card_button_pressed():
	add_card_to_selected_list(DASH_CARD.instantiate())
	# add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/DashCardButton.texture_normal)


func _on_laser_card_button_pressed():
	add_card_to_selected_list(LASER_CARD.instantiate())
	# add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/LaserCardButton.texture_normal)


func _on_lock_pick_card_button_pressed():
	add_card_to_selected_list(DOOR_CARD.instantiate())
	# add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/LockPickCardButton.texture_normal)


func _on_bomb_card_button_pressed():
	add_card_to_selected_list(BOMB_CARD.instantiate())
	# add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/BombCardButton.texture_normal)


func _on_get_treasure_card_button_pressed():
	add_card_to_selected_list(GET_CARD.instantiate())
	# add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/GetTreasureCardButton.texture_normal)


func _on_execute_pressed():
	on_next_pressed.emit()
