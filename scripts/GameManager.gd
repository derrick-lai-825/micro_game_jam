extends Node
	
@onready var music = $Music

@export var timer_duration: float = 10
@export var timer_end: float = 0.1
@export var conveyer_speed: float = 1
@export var music_bpm: int = 120


# Called when the node enters the scene tree for the first time.
func _ready():
	MicrogameJamController.SetMaxTimer(timer_duration)
	music.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if MicrogameJamController.GetTimer() < timer_end:
		MicrogameJamController.WinGame()
		print("WIN!!")
	pass

func GetBPM() -> int:
	return music_bpm;

func GetConveyerSpeed() -> float:
	return conveyer_speed;
