extends Node2D
class_name Checkpoint

@export var spawn_point = false
var activated = false

func activate():
	GameManager.checkPoint = self
	activated = true
	$AnimationPlayer.play("activate")


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !activated:
		activate()
