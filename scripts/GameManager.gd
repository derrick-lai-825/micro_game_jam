extends Node

# Node References
@onready var music = $Music
@onready var timer = $Timer

# Export Variables
@export var timer_duration: float = 10
@export var timer_end: float = 0.1
@export var conveyer_speed: float = 1
@export var music_bpm: int = 120

# Variables
var timer_interval: float = 60.0 / music_bpm
var num_of_bots: int = 8

func _ready():
	MicrogameJamController.SetMaxTimer(timer_duration)
	music.play()
	timer.start(timer_interval)
	pass # Replace with function body.

func _process(delta):
	
	if MicrogameJamController.GetTimer() < timer_end:
		MicrogameJamController.WinGame()
		print("WIN!!")
	pass

func GetConveyerSpeed() -> float:
	return conveyer_speed;
