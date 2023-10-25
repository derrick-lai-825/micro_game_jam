extends Node2D
@onready var throw : AudioStreamPlayer2D = $Throw
@onready var pas : AudioStreamPlayer2D = $Pass
@onready var fail : AudioStreamPlayer2D = $Fail
@onready var rise : AudioStreamPlayer2D = $Rise
@onready var metal = $Metal
@onready var miss = $Miss

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Throw():
	throw.play()
	pass

func Pass():
	pas.play()
	pass

func Fail():
	fail.play()
	pass

func Rise():
	rise.play()
	pass

func Metal():
	metal.play()
	pass

func Miss():
	miss.play()
	pass
