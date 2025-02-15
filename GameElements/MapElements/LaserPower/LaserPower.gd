extends Node

var laser_zone: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	laser_zone = self.get_node("LaserZone")
	assert(laser_zone != null, "[LaserPower] Error : LaserPower must have the corresponding LaserZone as child")
	assert(laser_zone.is_in_group("LaserZone"), "[LaserPower] Error : LaserPower must have the corresponding LaserZone as child")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func disable_laser():
	laser_zone.queue_free()
