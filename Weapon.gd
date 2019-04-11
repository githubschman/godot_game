extends RigidBody2D

# weapon class vars
export (String) var NAME
export (int) var CAPACITY

export (bool) var isActive = false

func _ready():
	# $Sprite
	pass

func _on_Visibility_screen_exited():
	queue_free()

func shoot():
	print('BOOOM!')