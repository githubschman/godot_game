extends RigidBody2D

# weapon class vars
export (String) var NAME
export (int) var CAPACITY

export (bool) var isActive = false
export (bool) var equipped = false

func _ready():
	# $Sprite
	pass

func _on_Visibility_screen_exited():
	queue_free()
	
func _process(delta):
	var Player = get_node("/root/Main/Player")
	if Player.inventory.size():	
		if equipped:
			position = Player.position
			if Player.velocity.x != 0:
				# $MainSprite.animation = "right"
				$MainSprite.flip_v = false
				$MainSprite.flip_h = Player.velocity.x < 0
			elif Player.velocity.y != 0:
				# $MainSprite.animation = "up"
				$MainSprite.flip_v = Player.velocity.y > 0

func shoot():
	print('BOOOM!')

	#var bullet = Bullet.instance()
	#add_child(bullet)
	#var direction = $Weapon.rotation + PI/2
	#bullet.rotation = direction
	#bullet.set_linear_velocity(Vector2(rand_range(bullet.MIN_SPEED, bullet.MAX_SPEED), 0).rotated(direction))
	