extends Node2D

# Export Variables
@export var texture_open : Texture2D
@export var texture_closed : Texture2D

@export var target_pos : Vector2 = Vector2.ZERO
@export var tween_time : float = 0.5 
@export var start_pos : Vector2 = Vector2.LEFT * 500
@export var start_rot : float = -0.25 
@export var end_pos : Vector2 = Vector2.RIGHT * 500
@export var end_rot : float = 0.25 

# Node References
@onready var sprite : Sprite2D = $Sprite2D
@onready var camera_manager = $"../Camera Manager"

# Called when the node enters the scene tree for the first time.
func _ready():
	Enter()
	pass # Replace with function body.

func Enter():
	sprite.texture = texture_closed
	sprite.rotation = start_rot
	position = start_pos
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "rotation", 0, tween_time)
	tween.parallel().tween_property(self, "position", target_pos, tween_time)
	tween.tween_property(sprite, "texture", texture_open, 0)
	tween.tween_callback(camera_manager.apply_noise_shake)

func Leave():
	sprite.texture = texture_closed
	camera_manager.apply_noise_shake(2)
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "rotation", end_rot, tween_time)
	tween.parallel().tween_property(self, "position", end_pos, tween_time)
	
func Mad():
	sprite.texture = texture_closed
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.1)
	tween.parallel().tween_property(sprite, "modulate", Color(1, 0.2, 0.2, 1), 0.1)
