extends CharacterBody2D
class_name Player

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var attacking = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	GameManager.player = self

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	attacking = true
	$AnimationPlayer.play("attack")
	
	var overlapping_areas = $AtackingArea.get_overlapping_areas()
	
	for area in overlapping_areas:
		print(area)
		if area.is_in_group("enemies"):
			area.get_parent().die()
		

func process_animations():
	if !attacking:
		if velocity.x != 0:
			$AnimationPlayer.play("run")
			if velocity.x < 0:
				$Sprite2D.flip_h = true
			else:
				$Sprite2D.flip_h = false
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
