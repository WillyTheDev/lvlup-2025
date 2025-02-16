class_name TextureButtonWithSound
extends TextureButton

var _audio_stream_player = null

# Preload the sound file
const SOUND_FILE = preload("res://Assets/Sounds/clic_button.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create audio stream player
	self._audio_stream_player = AudioStreamPlayer.new()
	self._audio_stream_player.volume_db = -10
	self._audio_stream_player.pitch_scale = 2.0
	self.add_child(self._audio_stream_player)
	self._audio_stream_player.stream = SOUND_FILE
	self.pressed.connect(_on_TextureButton_pressed)

func _on_TextureButton_pressed():
	self._audio_stream_player.play()
