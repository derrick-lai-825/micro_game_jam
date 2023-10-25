extends Node

# Node References
@onready var music = $Music
@onready var timer = $Timer
@onready var camera_manager = $"../Camera Manager"
@onready var bolt_manager = $"Bolt Manager"
@onready var bot_fridge = $"../Bot_Fridge"
@onready var bot_leg = $"../Bot_Leg"
@onready var bot_float = $"../Bot_Float"
@onready var sound_manager = $"../Sound Manager"

# Export Variables
@export var extra_end: float = 0.5
@export var timer_duration: float = 12
@export var timer_end: float = 0.1
@export var conveyer_speed: float = 750
@export var music_bpm: int = 160

# Variables
var timer_interval: float = 30.0 / music_bpm
var num_of_bots: int = 8
var lose: bool = false
var bot: Node2D

func _ready():
	# MicrogameJamController.SetMaxTimer(timer_duration)
	WebJamController.SetMaxTimer(timer_duration)
	timer.start(timer_interval)
	camera_manager.Zoom()
	music.play()
	conveyer_speed = WebJamController.GetSpeed()
	
	# match MicrogameJamController.GetDifficulty():
	match WebJamController.GetDifficulty():
		1:
			bot = bot_float
		2:
			bot = bot_fridge
		3:
			bot = bot_leg
	bot.visible = true

func _process(delta):
	
	# if !lose and MicrogameJamController.GetTimer() < timer_end:
	if !lose and WebJamController.GetTimer() < timer_end:
		# MicrogameJamController.WinGame()
		WebJamController.WinGame()
		print("WIN!!")
	# elif !lose and MicrogameJamController.GetTimer() < extra_end:
	elif !lose and WebJamController.GetTimer() < extra_end:
		sound_manager.Pass()
		bot.Leave()
		bolt_manager.DestroyBolts()

func GetConveyerSpeed() -> float:
	return conveyer_speed;
	
func Correct(bolt : Node) -> void:
	camera_manager.apply_noise_shake()
	bolt_manager.ShootBolt(bolt)

func Miss() -> void:
	lose = true
	var tween = create_tween()
	bot.Mad()
	bolt_manager.DestroyBolts()
	tween.tween_callback(camera_manager.Bot).set_delay(0.25)
	tween.tween_callback(sound_manager.Fail)
	# tween.tween_callback(MicrogameJamController.LoseGame).set_delay(0.5)
	tween.tween_callback(WebJamController.LoseGame).set_delay(0.5)

func Cat(bolt : Node2D):
	lose = true
	bolt_manager.ShootBolt(bolt)
	var tween = bolt.create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(bolt.get_node("Sprite2D"), "modulate", Color(1, 0.2, 0.2, 1), 0.25)
	tween.parallel().tween_property(bolt.get_node("Sprite2D"), "scale", Vector2(2, 2), 0.25)
	tween.tween_callback(camera_manager.Cat)
	tween.tween_callback(sound_manager.Rise)
	# tween.tween_callback(MicrogameJamController.LoseGame).set_delay(0.5)
	tween.tween_callback(WebJamController.LoseGame).set_delay(0.5)
