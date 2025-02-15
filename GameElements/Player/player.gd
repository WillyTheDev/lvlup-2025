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
var closest_enemy : Node2D = null
var closest_wall : Node2D = null
var closest_treasure : Node2D = null
var closest_door : Node2D = null
var closest_switch : Node2D = null
var tween: Tween

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
	if %BombZone.get_overlapping_bodies().any(func(body): if body.get_parent() is Treasure:
			if closest_treasure == null:
				closest_treasure = body.get_parent()
				closest_treasure.set_outline(true)
			return true) == false:
				if closest_treasure != null:
					closest_treasure.set_outline(false)
					closest_treasure = null

func get_closest_enemy():
	if %CheckZone.get_overlapping_bodies().any(func(body): if body is Enemy:
			if closest_enemy == null:
				closest_enemy = body
				body.set_outline(true)
			else:
				var distance = self.global_position.distance_to(body.global_position)
				if distance < (self.global_position.distance_to(closest_enemy.global_position)):
					closest_enemy.set_outline(false)
					closest_enemy = body
					body.set_outline(true)
			return true) == false:
				if closest_enemy != null:
					closest_enemy.set_outline(false)
					closest_enemy = null
					
func get_closest_wall():
	if %BombZone.get_overlapping_bodies().any(func(body): if body.get_parent() is Wall:
			if closest_wall == null:
				closest_wall = body.get_parent()
				closest_wall.set_outline(true)
			else:
				var distance = self.global_position.distance_to(body.get_parent().global_position)
				if distance < (self.global_position.distance_to(closest_wall.global_position)):
					closest_wall.set_outline(false)
					closest_wall = body.get_parent()
					closest_wall.set_outline(true)
			return true) == false:
				if closest_wall != null:
					closest_wall.set_outline(false)
					closest_wall = null

func get_closest_door():
	if %BombZone.get_overlapping_bodies().any(func(body): if body.get_parent() is Door:
			if closest_door == null:
				closest_door = body.get_parent()
				closest_door.set_outline(true)
			else:
				var distance = self.global_position.distance_to(body.get_parent().global_position)
				if distance < (self.global_position.distance_to(closest_door.global_position)):
					closest_door.set_outline(false)
					closest_door = body.get_parent()
					closest_door.set_outline(true)
			return true) == false:
				if closest_door != null:
					closest_door.set_outline(false)
					closest_door = null
					
func get_closest_switch():
	if %BombZone.get_overlapping_bodies().any(func(body): if body.get_parent() is Switch:
			if closest_switch == null:
				closest_switch = body.get_parent()
				closest_switch.set_outline(true)
			else:
				var distance = self.global_position.distance_to(body.get_parent().global_position)
				if distance < (self.global_position.distance_to(closest_switch.global_position)):
					closest_switch.set_outline(false)
					closest_switch = body.get_parent()
					closest_switch.set_outline(true)
			return true) == false:
				if closest_switch != null:
					closest_switch.set_outline(false)
					closest_switch = null
	
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

func open_closest_door():
	if closest_door != null:
		%Camera2D.apply_shake(2, self.global_position)
		closest_door.unlock()
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
