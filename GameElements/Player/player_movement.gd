extends CharacterBody2D


@export var player_speed: int = 400
@export var dash_speed: int = 1000
@export var game_manager: Node2D = null
var dash_velocity: int = 0
var can_stun := false
var can_destroy_wall := false
var can_get_treasure := false
var closest_enemy : Node2D = null
var closest_wall : Node2D = null
var closest_treasure : Node2D = null
var tween: Tween

func _ready():
	game_manager._player_has_been_catched.connect(kill_player)

func kill_player():
	self.queue_free()
	
func _process(delta):
	if can_stun:
		get_closest_enemy()
	if can_destroy_wall:
		get_closest_wall()
	if can_get_treasure:
		get_closest_treasure()
				
						

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
	
func stun_closest_enemy():
	closest_enemy.queue_free()
	closest_enemy = null
	
func destroy_closest_wall():
	closest_wall.destroys()
	closest_wall = null
	
func get_treasure():
	closest_treasure.take()
	closest_treasure = null
	


func play_animation_idle():
	%PlayerAnimation.play("idle")
	
func play_animation_walk():
	%PlayerAnimation.play("walk")
