extends Node

export (PackedScene) var Mob
export (PackedScene) var Weapon

var time = 60
var livesNum = 3

func _ready():
	randomize()
	
func new_game():
	time = 60
	livesNum = 3
	$HUD.update_lives(livesNum)
	$HUD.update_time(time)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$Music.play()
	add_weapons_to_scene(3)

func win_game():
	cleanUpScene()
	$HUD.show_game_over("You Won!")
	
func cleanUpScene():
	$Player.hide()
	$Music.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	var colNode = get_node("/root/Main/Player/Collision")
	colNode.disabled = true
	get_tree().call_group(SceneTree.GROUP_CALL_DEFAULT,"Weapon","queue_free")
	
func player_hit():
	if time < 60:
		$DeathSound.play()
		livesNum = livesNum - 1
		$HUD.update_lives(livesNum)
		if livesNum == 0:
			cleanUpScene()
			$HUD.show_game_over("Game Over")

func player_equip():
	var size = $Player.inventory.size()
	$HUD.update_inventory(size)
	if size == 1:
		player_change_active_weapon()

func player_change_active_weapon():
	var newIndex = $Player.activeWeapon - 1
	$HUD.update_active_weapon($Player.inventory[newIndex].NAME)

func add_weapons_to_scene(weaponNum):
	# this is just for testing!
	for i in range (0, weaponNum):
		var weapon = Weapon.instance()
		weapon.NAME = "test_weapon_" + str(i)
		add_child(weapon)
		$WeaponPath/WeaponSpawnLocation.set_offset(randi())
		var pos = $WeaponPath/WeaponSpawnLocation.position
		pos.y = pos.y + randi()%600+100
		weapon.position = pos

func _on_MobTimer_timeout():
	# choose a random location on the Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	mob.position = $MobPath/MobSpawnLocation.position
	# add some randomness to the direction
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))
	
func _on_StartTimer_timeout():
	# $MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	time -= 1
	if time == 0:
		win_game()
	$HUD.update_time(time)

