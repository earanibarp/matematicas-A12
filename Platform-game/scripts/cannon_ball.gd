extends Node2D

var direction
var speed = 300
var lifetime = 2
var hit = false

func _ready():
	await get_tree().create_timer(lifetime).timeout
	die()

func die():
	hit = true
	speed = 0
	$AnimationPlayer.play("hit")
	

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !hit:
		area.get_parent().take_damage(1)
		die()

func _physics_process(delta):
	position.x += abs(speed * delta) * direction
