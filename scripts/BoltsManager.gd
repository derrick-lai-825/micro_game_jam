extends Node

# Export Variables
@export var spawn_pos: Vector2 = Vector2(-300, 50)
@onready var game_manager = $".."

# Node References
var bolt: PackedScene = preload("res://scenes/bolt.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for b in get_children():
		b.position += Vector2(game_manager.GetConveyerSpeed() * delta, 0)

func Spawn():
	var b: Node = bolt.instantiate()
	b.position = spawn_pos
	add_child(b)
