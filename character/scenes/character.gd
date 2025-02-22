extends CharacterBody2D

signal continue_dialogue

@onready 
var sprite: AnimatedSprite2D = $Character
var music_ended = false
@export
var speed: int = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if music_ended:
		$AudioStreamPlayer2D.play()
		music_ended = false
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
	
	
func _on_audio_stream_player_2d_finished() -> void:
	music_ended = true
	
func show_next_wizard_dialogue(is_first:bool=false):
	if is_first:
		await get_tree().create_timer(0.3).timeout
		$Control/Dialogue.visible = true
		await get_tree().create_timer(0.3).timeout
		$Control/Dialogue.show_text()
		print("Player before emitting")
		continue_dialogue.emit()
		print("Player after emitting")
	else:
		$Control/Dialogue.show_text()
		continue_dialogue.emit()
		print("Player after emitting")
		

	
func show_nuke_dialog():
	$Control/SelfDialogue.show_text("Press N to nuke the wizard.")
