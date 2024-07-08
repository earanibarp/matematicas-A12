extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


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

	move_and_slide()
	process_animations()
	

func process_animations():
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
	
	#print($AnimationPlayer.current_animation)
