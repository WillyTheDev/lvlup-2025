extends CharacterBody2D


@export var player_speed: int = 400
@export var dash_speed: int = 1000
var dash_velocity: int = 0

var tween: Tween

func _ready():
	get_node("/root/Map/GameManager")._player_has_been_catched.connect(kill_player)

func kill_player():
	self.queue_free()

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


func play_animation_idle():
	%PlayerAnimation.play("idle")
	
func play_animation_walk():
	%PlayerAnimation.play("walk")
