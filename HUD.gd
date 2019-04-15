extends CanvasLayer

signal start_game
			
func _ready():
	$LivesLabel.hide()
	$ScoreLabel.hide()
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over(message):
	$LivesLabel.hide()
	show_message(message)
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Get ready!"
	$MessageLabel.show()
	
func update_time(time):
	$ScoreLabel.text = str(time)

func update_lives(lifeCount):
	var scoreText = "Lives " + str(lifeCount)
	$LivesLabel.text = scoreText
	
func update_inventory(text):
	var inventoryText = "Weapons: " + str(text)
	$InventoryLabel.text = inventoryText

func update_active_weapon(weapon_name, weapon_capacity):
	var activeWeaponText = "Active Weapon: " + str(weapon_name) + " " + str(weapon_capacity)
	$ActiveWeaponLabel.text = activeWeaponText

func _on_StartButton_pressed():
	$StartButton.hide()
	$LivesLabel.show()
	$ScoreLabel.show()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()