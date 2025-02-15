extends Node

var node_wall: Node = null
var node_door: Node = null
var node_laser_power: Node = null
var node_laser_zone: Node = null
var node_object_stolen: Node = null
var gamemanager: Node = null

enum ObjectTypes {
	Wall,
	Door,
	LaserPower,
	LaserZone,
	ObjectStolen
}

var object_selected = ObjectTypes.Wall

func _ready():
	node_door = get_node("/root/Map/Objects/DoorClosed")
	node_laser_power = get_node("/root/Map/Objects/LaserPower")
	node_laser_zone = get_node("/root/Map/Objects/LaserPower/LaserZone")
	node_object_stolen = get_node("/root/Map/Objects/ObjectStolen")
	node_wall = get_node("/root/Map/Objects/Wall")

	gamemanager = get_node("/root/Map/GameManager")

func _input(event):
	if event.is_action_pressed("use_card"):
		print("[input] use_card action key pressed")

		if object_selected == ObjectTypes.Wall:
			node_wall.destroys()

		elif object_selected == ObjectTypes.Door:
			node_door.open_door()

		elif object_selected == ObjectTypes.LaserPower:
			node_laser_power.disable_laser()

		elif object_selected == ObjectTypes.LaserZone:
			gamemanager.player_catch()

		elif object_selected == ObjectTypes.ObjectStolen:
			node_object_stolen.take()

		var next_int = (object_selected + 1) % ObjectTypes.values().size()
		print(next_int)
		var object_key = ObjectTypes.keys()[next_int]
		object_selected = ObjectTypes[object_key]
