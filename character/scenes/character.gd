extends CharacterBody2D

@onready 
var sprite: AnimatedSprite2D = $Character

@export
var speed: int = 6
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.ZERO
	speed = 6
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_up"):
		direction.y = -1
		sprite.play('walk_up')
	elif Input.is_action_pressed("move_right"):
		direction.x = 1
		sprite.play("walk_right")
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
		sprite.play("walk_left")
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
		sprite.play("default")
	if Input.is_action_pressed("sprint"):
		speed = 12
	

	#direction = direction.normalized() * speed
	self.position += direction * speed
	#velocity = direction * speed
	move_and_collide(direction)
	
	

