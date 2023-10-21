extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
func _input(event):
	
	var curr_color = Color(0, 1, 0)
	if event.is_action_pressed("ui_accept"):
		$Sprite2D.modulate = Color(0, 1, 0)
		print("Hello")
	else:
		$Sprite2D.modulate = Color(1, 0, 0)
