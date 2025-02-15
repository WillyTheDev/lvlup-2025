class_name GameManager
extends Node

signal _player_has_been_catched

func player_catch():
	_player_has_been_catched.emit()
	print("Player has been Catched !")
