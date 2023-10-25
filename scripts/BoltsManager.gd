extends Node

# Export Variables
@export var spawn_pos: Vector2 = Vector2(-562.5, 120)
@export var tween_time: float = 60.0 / 160
@export var tween_size: float = 0.25
@export var target_pos: Vector2 = Vector2(0, -95)
@export var rand_pos: Vector2 = Vector2(60, 30)
@export var rand_size: float = 0.05
@export var fade_time: float = 0.2

# Node References
var bolt_scene: PackedScene = preload("res://scenes/bolt.tscn")
var cat_scene: PackedScene = preload("res://scenes/cat_bolt.tscn")
@onready var game_manager = $".."
@onready var belt : Sprite2D = $"../../Belt"
@onready var sound_manager = $"../../Sound Manager"

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_pos = Vector2(WebJamController.GetSpeed() * -0.75, 120)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MoveBolts(delta)
	MoveBelt(delta)

func Spawn():
	var bolt: Node = bolt_scene.instantiate()
	bolt.position = spawn_pos
	add_child(bolt)
	
func SpawnCat():
	var cat: Node = cat_scene.instantiate()
	cat.position = spawn_pos
	add_child(cat)

func ShootBolt(bolt : Node):
	bolt.get_child(1).queue_free()
	# bolt.get_child(2).emitting = true
	# bolt.get_child(2).reparent(get_parent())
	var tween = bolt.create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var size : Vector2 = Vector2.ONE * (tween_size + randf_range(-rand_size, rand_size))
	tween.tween_property(bolt, "scale", size, tween_time)
	tween.parallel().tween_property(bolt, "rotation", randi_range(-3, 3), tween_time)
	var pos : Vector2 = target_pos + Vector2(randf_range(-rand_pos.x, rand_pos.x), randf_range(-rand_pos.y, rand_pos.y))
	tween.parallel().tween_property(bolt, "position", pos, tween_time).set_trans(Tween.TRANS_BACK)
	# tween.tween_callback(sound_manager.Metal)
	# tween.tween_property(bolt.get_child(0), "modulate", Color(1, 1, 1, 0), fade_time)
	# tween.tween_callback(bolt.queue_free)
	
func DestroyBolts() -> void:
	for bolt in get_children():
		if bolt.scale.length() < 1:
			bolt.queue_free()
			
func MoveBolts(delta) -> void:
	for bolt in get_children():
		if bolt.scale.length() >= 1:
			bolt.position += Vector2(game_manager.GetConveyerSpeed() * delta, 0)
		if bolt.position.x > 200 and bolt.scale.x == 1:
			Miss(bolt)

func MoveBelt(delta) -> void:
	var new_pos: float = belt.region_rect.position.x - game_manager.GetConveyerSpeed() * delta * 3
	belt.region_rect.position = Vector2(new_pos, 0)

func Miss(bolt):
	var tween = bolt.create_tween()
	tween.tween_property(bolt.get_node("Sprite2D"), "modulate", Color(1, 0.2, 0.2, 1), 0.25)
	tween.tween_callback(game_manager.Miss)
	pass
