extends Area2D

func _ready():
	# Connect the body_entered signal to the _on_Area2D_body_entered function$"."
	pass



func _on_area_entered(area):
	print('Collision detected')


func _on_body_entered(body):
	print('Collision detected')
	pass # Replace with function body.
