extends Node2D

var difficulty : int = 1
var timer : float = 12
var base_speed : float = 750
var speed : float = 750
var iteration : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = base_speed * (log(iteration + 1) / log(4) + 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (timer > 0):
		timer -= delta
	else:
		LoseGame()
	
func SetMaxTimer(time: float) -> void:
	timer = time
	
func GetTimer() -> float:
	return timer
	
func GetSpeed() -> float:
	return speed
	
func GetDifficulty() -> int:
	return difficulty

func WinGame() -> void:
	difficulty += 1
	if (difficulty > 3):
		difficulty = 1
		iteration += 1
		speed = base_speed * (log(iteration + 1) / log(2.71) + 1)
	get_tree().reload_current_scene()
	pass

func LoseGame() -> void:
	get_tree().reload_current_scene()
	pass
