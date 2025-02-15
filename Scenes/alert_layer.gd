extends CanvasLayer

func show_layer():
	self.visible = true
	%AnimationPlayer.play("alert")

func stop_layer():
	self.visible = false
