extends Node

# Export Variables
@export var spawn_pos: Vector2 = Vector2(-300, 50)
@export var tween_time: float = 0.5
@export var tween_size: float = 0.25
@export var target_pos: Vector2 = Vector2(0, -95)
@export var rand_pos: Vector2 = Vector2(60, 30)
@export var rand_size: float = 0.05
@export var fade_time: float = 0.2

# Node References
var bolt_scene: PackedScene = preload("res://scenes/bolt.tscn")
@onready var game_manager = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for bolt in get_children():
		if bolt.scale.length() >= 1:
			bolt.position += Vector2(game_manager.GetConveyerSpeed() * delta, 0)
		if bolt.position.x > 500:
			bolt.queue_free()

func Spawn():
	var bolt: Node = bolt_scene.instantiate()
	bolt.position = spawn_pos
	add_child(bolt)

func ShootBolt(bolt : Node):
	bolt.get_child(1).queue_free()
	var tween = bolt.create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var size : Vector2 = Vector2.ONE * (tween_size + randf_range(-rand_size, rand_size))
	tween.tween_property(bolt, "scale", size, tween_time)
	tween.parallel().tween_property(bolt, "rotation", randi_range(-3, 3), tween_time)
	var pos : Vector2 = target_pos + Vector2(randf_range(-rand_pos.x, rand_pos.x), randf_range(-rand_pos.y, rand_pos.y))
	tween.parallel().tween_property(bolt, "position", pos, tween_time).set_trans(Tween.TRANS_BACK)
	# tween.tween_property(bolt.get_child(0), "modulate", Color(1, 1, 1, 0), fade_time)
	# tween.tween_callback(bolt.queue_free)
	
func DestroyBolts():
	for bolt in get_children():
		if bolt.scale.length() < 1:
			bolt.queue_free()
