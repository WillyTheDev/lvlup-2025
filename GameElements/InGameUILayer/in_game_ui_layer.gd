extends CanvasLayer

@export var cardManager: CardManager
@export var gameManager: Node2D

var timerText: String = "00:00"
var goalText: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	%TimerText.text = "%02d:%02d" % [int(gameManager.elapsed_time) / 60, int(gameManager.elapsed_time) % 60]
	%GoalText.text = self.goalText


func _on_retry_button_pressed():
	gameManager.player_catch()
