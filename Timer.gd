extends Timer


@onready var area_2d = $"../Area2D"
var item = preload("res://testitem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timeout():
	randomize()
	var body = item.instantiate()
	body.position = Vector2(50, 50)
	add_child(body)
	wait_time = 1
