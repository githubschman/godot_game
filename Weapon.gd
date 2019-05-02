extends RigidBody2D

export (PackedScene) var Bullet
export (PackedScene) var TestMob

# weapon class vars
export (String) var NAME
export (int) var CAPACITY
export (int) var MIN_SPEED = 150
export (int) var MAX_SPEED = 250 # test values....

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
			rotation = Player.rotation
			# if Player.velocity.x != 0:
				# $MainSprite.animation = "right"
			# elif Player.velocity.y != 0:
				# $MainSprite.animation = "up"

func shoot():
	if CAPACITY > 0:
		CAPACITY = CAPACITY - 1
		var Player = get_node("/root/Main/Player")
		var HUD = get_node("/root/Main/HUD")
		if CAPACITY == 0:
			equipped = false
			var newWeapon = Player.activeWeapon - 1
			Player.inventory.erase(Player.inventory[Player.activeWeapon - 1])
			Player.activeWeapon - newWeapon
			hide()
			if Player.inventory.size() && Player.inventory[Player.activeWeapon - 1]:
				Player.inventory[Player.activeWeapon - 1].show()
				HUD.update_active_weapon(Player.inventory[Player.activeWeapon - 1].NAME, Player.inventory[Player.activeWeapon - 1].CAPACITY)
			# else:
				# hide active weapon label
		else: #
			HUD.update_active_weapon(NAME, CAPACITY)
			var bullet = Bullet.instance()
			get_parent().add_child(bullet)
			var direction = Player.rotation
			bullet.global_position = global_position
			bullet.VELOCITY = Vector2(rand_range(MIN_SPEED, MAX_SPEED), 0).rotated(direction)
			