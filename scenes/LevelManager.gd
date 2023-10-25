extends Node2D
@export var beat : int = 0

@export var level_easy : Array[int]
@export var cat_easy : Array[int]
@export var level_med : Array[int]
@export var cat_med : Array[int]
@export var level_hard : Array[int]
@export var cat_hard : Array[int]
@onready var bolt_manager = $"../Bolt Manager"

var level : Array[int]
var cat : Array[int]
# Called when the node enters the scene tree for the first time.
func _ready():
	# match MicrogameJamController.GetDifficulty():
	match WebJamController.GetDifficulty():
		1:
			level = level_easy
			cat = cat_easy
		2: 
			level = level_med
			cat = cat_med
		3:
			level = level_hard
			cat = cat_hard
			pass
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func OnBeat():
	beat += 1
	
	if (level.size() > 0 and beat == level[0]):
		bolt_manager.Spawn()
		level.pop_front()
	
	if (cat.size() > 0 and beat == cat[0]):
		bolt_manager.SpawnCat()
		cat.pop_front()
	
	# Checks w
	pass # Replace with function body.
