extends RigidBody2D

export (int) var VELOCITY

func _process(delta):
    move(delta)

func move(delta):
    global_position += VELOCITY * delta

func _on_Visibility_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	print("hit with bullet")
