extends Node2D

@export var spawn_point = false
var activated = false

func activate():
	activated = true
	$AnimationPlayer.play("activate")


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		activate()
