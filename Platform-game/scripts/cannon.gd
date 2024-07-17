extends StaticBody2D

var cannon_ball = load("res://scenes/cannon_ball.tscn")
var cannon_destroyed = load("res://scenes/cannon_destroyed.tscn")

@export var shooting: bool
var firerate = 2

var max_health = 3
var health

func _ready():
	health = max_health
	shooting = true
	shoot()

func shoot():
	while shooting:
		$AnimationPlayer.play("fire")
		await get_tree().create_timer(firerate).timeout

func fire():
	var spawn_ball = cannon_ball.instantiate()
	spawn_ball.direction = $FirePoint.scale.x
	spawn_ball.global_position = $FirePoint.position
	add_child(spawn_ball)

func take_damage(damage_amount):
	health -= damage_amount
	$AnimationPlayer.play("hit")
	get_node("healthBar").update_healthBar(health, max_health)
	if health <= 0:
		die()
	

func die():
	var spawn_destroyed = cannon_destroyed.instantiate()
	spawn_destroyed.global_position = position
	spawn_destroyed.scale.x = scale.x
	spawn_destroyed.get_child(1).play("crumble")
	get_tree().get_root().get_child(1).add_child(spawn_destroyed)
	queue_free()
