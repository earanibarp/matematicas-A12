extends CharacterBody2D


@export var speed = -100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = false
var tween
var dead = false

var max_health = 1
var health

func _ready():
	health = max_health
	$AnimationPlayer.play("run")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = speed
	move_and_slide()
	
	if !$RayCast2D.is_colliding() && is_on_floor() or is_on_wall():
		flip()

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1


func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead:
		area.get_parent().take_damage(1)

func take_damage(damage_amount):
	health -= damage_amount
	get_node("healthBar").update_healthBar(health, max_health)
	if health <= 0:
		die()

func die():
	dead = true
	speed = 0
	$AnimationPlayer.play("dead")
	await get_tree().create_timer(1).timeout
	queue_free()
	
func tween_animation():
	tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1,1,1,0), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
