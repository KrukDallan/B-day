extends CharacterBody2D

signal continue_dialogue

@onready 
var sprite: AnimatedSprite2D = $Character
var music_ended = false
@export
var speed: int = 10
var can_move = true

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
	#self.position += direction * speed
	#velocity = direction * speed
	if can_move:
		move_and_collide(direction*speed)
	
func set_can_move(value: bool):
	print("set")
	can_move = value
	
func _on_audio_stream_player_2d_finished() -> void:
	music_ended = true
	
func stop_music():
	$AudioStreamPlayer2D.stop()
	
func show_next_wizard_dialogue(is_first:bool=false):
	if is_first:
		await get_tree().create_timer(0.3).timeout
		$Control/Dialogue.visible = true
		await get_tree().create_timer(0.3).timeout
		$Control/Dialogue.activate_dialogue()
		
func show_second_wizard_dialogue():
	$Control/Dialogue.show_second_wiz_text()
	
func show_third_wizard_dialogue():
	$Control/Dialogue.show_third_wiz_text()
		
func show_nuke_dialog():
	$Control/SelfDialogue.show_text("Press N to nuke the wizard.")
	#await get_tree().create_timer(3).timeout
	#$Control/Dialogue.show_last_wiz_text()
