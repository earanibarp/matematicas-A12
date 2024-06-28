extends Sprite2D

@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100,100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("right"):
		print("Derecha")
		position.x += speed * delta
	if Input.is_action_pressed("left"):
		print("Izquierda")
		position.x += -speed * delta
	if Input.is_action_pressed("up"):
		print("Arriba")
		position.y += -speed * delta
	if Input.is_action_pressed("down"):
		print("Abajo")
		position.y += speed * delta
