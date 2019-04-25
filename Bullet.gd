extends RigidBody2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_Visibility_screen_exited():
	queue_free()
