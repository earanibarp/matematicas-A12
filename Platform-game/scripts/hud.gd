extends CanvasLayer

func update_coins(coins):
	$Label.text = str(GameManager.coins)

func _ready():
	GameManager.gained_coins.connect(update_coins)
