extends Area2D

signal hit
signal equip
signal update_active_weapon

export (int) var SPEED
var velocity = Vector2()
var screensize
var hits
var activeWeapon = null
var inventory = []

func _ready():
	hide()
	screensize = get_viewport_rect().size
	rotation = PI
	rotation_degrees = 0
	
func start(pos):
	# TODO: move to reset properties?
	position = pos
	inventory = []
	activeWeapon = null
	show()
	$Collision.disabled = false

func _input(event):
	var weapon = null
	if inventory.size():
		weapon = inventory[activeWeapon - 1]
		weapon.position = position
		if event.is_pressed() && event.is_action("ui_change_weapon"):
			# hide current active weapon
			inventory[activeWeapon - 1].hide()
			activeWeapon = (activeWeapon + 1) % inventory.size()
			# show updated active weapon
			inventory[activeWeapon - 1].show()
			emit_signal("update_active_weapon")

func _process(delta):	
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		rotation_degrees = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		rotation_degrees = 180 #
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		rotation_degrees = 90 #
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		rotation_degrees = -90
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

	# if velocity.x != 0:
		# $AnimatedSprite.animation = "right"
	# elif velocity.y != 0:
		# $AnimatedSprite.animation = "up"

	# TODO add more obvs

func _on_Player_body_entered(body):
	var bodyName = body.get_name()
	print(bodyName)
	if ("Mob" in bodyName):
		body.hide()
		emit_signal("hit")
	elif ("Weapon" in bodyName):
		if (!inventory.has(body)):
			body.equipped = true
			inventory.insert(inventory.size(), body)
			if (activeWeapon == null):
				activeWeapon = 1
			else:
				body.hide()
			emit_signal("equip")
