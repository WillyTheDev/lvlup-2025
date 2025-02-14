extends CharacterBody2D


@export var player_speed: int = 30.0
@export var dash_speed: int = 100
var should_dash = false
var dash_velocity: int = 0

var tween: Tween

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if should_dash:
		dash_velocity = dash_speed
		if tween:
			tween.stop
		tween = create_tween()
		tween.tween_property(self, "dash_velocity", 0, 0.3).set_ease(Tween.EASE_OUT)
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
	should_dash = true
	


func play_animation_idle():
	%PlayerAnimation.play("idle")
	
func play_animation_walk():
	%PlayerAnimation.play("walk")
