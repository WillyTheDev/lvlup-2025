extends CanvasLayer

@export var maximum_amount_of_card := 5
var number_of_selected_card = 0

func add_card_to_selected_list(texture):
	if number_of_selected_card < maximum_amount_of_card: 
		number_of_selected_card += 1
		const CARD = preload("res://UI/SelectedCard/selected_card.tscn")
		var new_card = CARD.instantiate()
		new_card.normal_texture = texture
		%SelectedCardList.add_child(new_card)



func _on_stun_card_button_pressed():
	add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/StunCardButton.texture_normal)


func _on_dash_card_button_pressed():
	add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/DashCardButton.texture_normal)


func _on_laser_card_button_pressed():
	add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/LaserCardButton.texture_normal)


func _on_lock_pick_card_button_pressed():
	add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/LockPickCardButton.texture_normal)


func _on_bomb_card_button_pressed():
	add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/BombCardButton.texture_normal)


func _on_get_treasure_card_button_pressed():
	add_card_to_selected_list($MarginContainer/VBoxContainer/GridContainer/GetTreasureCardButton.texture_normal)
