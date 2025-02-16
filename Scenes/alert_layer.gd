extends CanvasLayer

func show_layer():
	self.visible = true
	%AnimationPlayer.play("alert")
	%AudioStreamPlayer.stream = preload("res://Assets/Music/Run Fast They Are Coming (with siren).mp3")
	%AudioStreamPlayer.play()

func stop_layer():
	self.visible = false
