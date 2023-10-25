extends Node2D

@onready var game_manager = $"../Game Manager"
@onready var sound_manager = $"../Sound Manager"
@onready var detector = $Detector
@onready var sparks : GPUParticles2D = $"../Sparks"

var current_bolt: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("Space"):
		Press()
	pass
	
func Press() -> void:
	if detector.has_overlapping_areas():
		# Correct
		print("Correct")
		BoltHandler()
	else:
		print("Fuck You")
		sound_manager.Miss()
		# Incorrect

func BoltHandler():
	sound_manager.Throw()
	# sparks.emitting = true
	current_bolt = detector.get_overlapping_areas()[0].get_parent()
	if current_bolt.scale.x < 1:
		print("Cat")
		game_manager.Cat(current_bolt) 
	else:
		print("Correct")
		sound_manager.Metal()
		game_manager.Correct(current_bolt)
