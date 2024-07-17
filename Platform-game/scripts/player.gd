extends CharacterBody2D
class_name Player

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var attacking = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var max_health = 2
var health = 0
var can_take_damage = true

func _ready():
	GameManager.player = self
	health = max_health

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if position.y >= 720:
		die()
	
	move_and_slide()
	process_animations()
	
func _process(delta):
	get_node("healthBar").update_healthBar(health, max_health)
	if Input.is_action_just_pressed("attack"):
		attack()
	else:
		attacking = false

func attack():
	attacking = true
	$AnimationPlayer.play("attack")
	
	var overlapping_areas = $AtackingArea.get_overlapping_areas()
	
	for area in overlapping_areas:
		print(area)
		if area.get_parent().is_in_group("enemies"):
			area.get_parent().take_damage(1)
		
		
func take_damage(damage_amount):
	if can_take_damage:
		invulnerable()
		health -= damage_amount
		if health <= 0:
			die()

func invulnerable():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

func process_animations():
	if !attacking:
		if velocity.x != 0:
			$AnimationPlayer.play("run")
			if velocity.x < 0:
				$Sprite2D.flip_h = true
				$AtackingArea.scale.x = abs($AtackingArea.scale.x) * -1
			else:
				$Sprite2D.flip_h = false
				$AtackingArea.scale.x = abs($AtackingArea.scale.x)
		else:
			$AnimationPlayer.play("idle")
	
		if velocity.y < 0:
			$AnimationPlayer.play("jump")
	
		if velocity.y > 0:
			$AnimationPlayer.play("fall")
	else:
		attacking = false
	
	#print($AnimationPlayer.current_animation)

func die():
	GameManager.respawn_player()
