extends Node

signal gained_coins(int)

var checkPoint: Checkpoint
var player: Player
var coins = 0

func respawn_player():
	player.health = player.max_health
	if checkPoint != null:
		player.position = checkPoint.global_position

func gain_coins(coins_gained):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)
	print(coins)
	
