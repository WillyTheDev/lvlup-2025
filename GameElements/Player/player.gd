class_name Player
extends CharacterBody2D

@export var player_speed: int = 400
@export var dash_speed: int = 1000
@export var game_manager: Node2D = null
@onready var player_camera = %Camera2D
var dash_velocity: int = 0
var can_stun := false
var can_destroy_wall := false
var can_get_treasure := false
var can_unlock_door := false
var can_disable_laser := false
var closest_enemy: Node2D = null
var closest_wall: Node2D = null
var closest_treasure: Node2D = null
var closest_door: Node2D = null
var closest_switch: Node2D = null
var tween: Tween
var has_treasure = false

func _ready():
	game_manager = $"../GameManager"
	game_manager.player_has_been_catched.connect(kill_player)

func kill_player():
	pass
	
func _process(delta):
	if can_stun:
		get_closest_enemy()
	if can_destroy_wall:
		get_closest_wall()
	if can_get_treasure:
		get_closest_treasure()
	if can_unlock_door:
		get_closest_door()
	if can_disable_laser:
		get_closest_switch()
				
						
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * (player_speed + dash_velocity)
	move_and_slide()
	if velocity.length() > 0.0:
		if %WalkAudio.playing == false:
			%WalkAudio.playing = true
		play_animation_walk();
		%DustParticle.emitting = true
		%DustParticle.process_material.gravity = Vector3(direction.x, direction.y, 0) * -1
	else:
		play_animation_idle();
		%WalkAudio.playing = false
		%DustParticle.emitting = false
		

func dash():
	print("Player Dash !")
	dash_velocity = dash_speed
	if tween:
		tween.stop
	tween = create_tween()
	tween.tween_property(self, "dash_velocity", 0, 0.5).set_ease(Tween.EASE_OUT)
	
func get_closest_treasure():
	# Get all overlapping bodies
	var overlapping_bodies = %BombZone.get_overlapping_bodies()
	# Get only the treasures
	var treasure_bodies = overlapping_bodies.filter(func(body): return body is Treasure)
	# If there are no treasures, remove the outline from the closest treasure
	if treasure_bodies.size() == 0:
		if closest_treasure != null:
			closest_treasure.set_outline(false)
			closest_treasure = null
		return
	# If there are treasures, find the closest one and set its outline
	for i in range(treasure_bodies.size()):
		var body = treasure_bodies[i]
		var distance = self.global_position.distance_to(body.global_position)
		if closest_treasure == null:
			closest_treasure = body
			closest_treasure.set_outline(true)
		else:
			var smallest_distance = self.global_position.distance_to(closest_treasure.global_position)
			if distance < smallest_distance:
				closest_treasure.set_outline(false)
				closest_treasure = body
				closest_treasure.set_outline(true)

func get_closest_enemy():
	# Get all overlapping bodies
	var overlapping_bodies = %CheckZone.get_overlapping_bodies()
	# Get only the enemies
	var enemy_bodies = overlapping_bodies.filter(func(body): return body is Enemy)
	# If there are no enemies, remove the outline from the closest enemy
	if enemy_bodies.size() == 0:
		if closest_enemy != null:
			closest_enemy.set_outline(false)
			closest_enemy = null
		return
	# If there are enemies, find the closest one and set its outline
	for i in range(enemy_bodies.size()):
		var body = enemy_bodies[i]
		var distance = self.global_position.distance_to(body.global_position)
		if closest_enemy == null:
			closest_enemy = body
			closest_enemy.set_outline(true)
		else:
			var smallest_distance = self.global_position.distance_to(closest_enemy.global_position)
			if distance < smallest_distance:
				closest_enemy.set_outline(false)
				closest_enemy = body
				closest_enemy.set_outline(true)
					
func get_closest_wall():
	# Get all overlapping bodies
	var overlapping_bodies = %BombZone.get_overlapping_bodies()
	# Get only the walls
	var wall_bodies = overlapping_bodies.filter(func(body): return body.get_parent() is Wall)
	# If there are no walls, remove the outline from the closest wall
	if wall_bodies.size() == 0:
		if closest_wall != null:
			closest_wall.set_outline(false)
			closest_wall = null
		return
	# If there are walls, find the closest one and set its outline
	for i in range(wall_bodies.size()):
		var body = wall_bodies[i].get_parent()
		var distance = self.global_position.distance_to(body.global_position)
		if closest_wall == null:
			closest_wall = body
			closest_wall.set_outline(true)
		else:
			var smallest_distance = self.global_position.distance_to(closest_wall.global_position)
			if distance < smallest_distance:
				closest_wall.set_outline(false)
				closest_wall = body
				closest_wall.set_outline(true)

func get_closest_door():
	# Get all overlapping bodies
	var overlapping_bodies = %BombZone.get_overlapping_bodies()
	# Get only the doors
	var door_bodies = overlapping_bodies.filter(func(body): return body.get_parent() is Door)
	# If there are no doors, remove the outline from the closest door
	if door_bodies.size() == 0:
		if closest_door != null:
			closest_door.set_outline(false)
			closest_door = null
		return
	# If there are doors, find the closest one and set its outline
	for i in range(door_bodies.size()):
		var body = door_bodies[i].get_parent()
		var distance = self.global_position.distance_to(body.global_position)
		if closest_door == null:
			closest_door = body
			closest_door.set_outline(true)
		else:
			var smallest_distance = self.global_position.distance_to(closest_door.global_position)
			if distance < smallest_distance:
				closest_door.set_outline(false)
				closest_door = body
				closest_door.set_outline(true)
					
func get_closest_switch():
	# Get all overlapping bodies
	var overlapping_bodies = %BombZone.get_overlapping_bodies()
	# Get only the switches
	var switch_bodies = overlapping_bodies.filter(func(body): return body.get_parent() is Switch)
	# If there are no switches, remove the outline from the closest switch
	if switch_bodies.size() == 0:
		if closest_switch != null:
			closest_switch.set_outline(false)
			closest_switch = null
		return
	# If there are switches, find the closest one and set its outline
	for i in range(switch_bodies.size()):
		var body = switch_bodies[i].get_parent()
		var distance = self.global_position.distance_to(body.global_position)
		if closest_switch == null:
			closest_switch = body
			closest_switch.set_outline(true)
		else:
			var smallest_distance = self.global_position.distance_to(closest_switch.global_position)
			if distance < smallest_distance:
				closest_switch.set_outline(false)
				closest_switch = body
				closest_switch.set_outline(true)
	
func stun_closest_enemy():
	if closest_enemy != null:
		%Camera2D.apply_shake(4, self.global_position)
		closest_enemy.stun()
		closest_enemy = null
	
func destroy_closest_wall():
	if closest_wall != null:
		%Camera2D.apply_shake(10, self.global_position)
		closest_wall.destroys()
		closest_wall = null
	
func get_treasure():
	if closest_treasure != null:
		closest_treasure.take()
		%Camera2D.apply_shake(2, self.global_position)
		game_manager.on_treasure_get()
		closest_treasure = null
		has_treasure = true

func open_closest_door():
	if closest_door != null:
		%Camera2D.apply_shake(2, self.global_position)
		closest_door.unlock_door()
		closest_door = null

func disable_closest_switch_laser():
	if closest_switch != null:
		closest_switch.disable_laser()
		%Camera2D.apply_shake(2, self.global_position)
		closest_switch = null

func play_animation_idle():
	%PlayerAnimation.play("idle")
	
func play_animation_walk():
	%PlayerAnimation.play("walk")
