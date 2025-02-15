extends CanvasLayer

@export var cardManager: CardManager

var timerText: String = "00:00"
var goalText: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	%TimerText.text = self.timerText
	%GoalText.text = self.goalText
