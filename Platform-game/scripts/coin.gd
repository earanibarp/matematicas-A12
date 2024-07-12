extends Node2D


func _ready():
	$AnimationPlayer.play("activate")


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		GameManager.gain_coins(1)
		$AnimationPlayer.play("collected")
		await get_tree().create_timer(0.5).timeout
		queue_free()
		
