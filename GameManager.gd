extends Node
	

@export var timer_duration: float = 15
@export var timer_end: float = 0.1
@export var conveyer_speed: float = 1
# @export var 

# Called when the node enters the scene tree for the first time.
func _ready():
	MicrogameJamController.SetMaxTimer(timer_duration)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print("Timer: ", MicrogameJamController.GetTimer())
	if MicrogameJamController.GetTimer() < timer_end:
		MicrogameJamController.WinGame()
		print("WIN!!")
	pass
