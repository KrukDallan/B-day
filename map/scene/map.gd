extends Node2D 

var first_dialogue = true
var can_continue = true
var is_challenge_going = false
@onready
var player = $Player

var start_challenge = false
var current_score: int = 0
var my_roll_id = -1
var wiz_animation_changed: bool = false

var first_score_reached = false
var second_score_reached = false
var target_nuke_y = -1498

var statue_interacted = false
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_challenge and is_challenge_going:
		$Control.visible = true
		var last_roll_id = get_tree().get_first_node_in_group("Dice").get_roll_id()
		if last_roll_id != my_roll_id:
			if Input.is_action_just_pressed("Addiction"):
				var last_roll = get_tree().get_first_node_in_group("Dice").get_last_roll()
				current_score += last_roll
				my_roll_id = last_roll_id
			elif Input.is_action_just_pressed("Subtraction"):
				var last_roll = get_tree().get_first_node_in_group("Dice").get_last_roll()
				current_score -= last_roll
				my_roll_id = last_roll_id
			$Control/Challenge/Current.text = str(current_score)
			if not first_score_reached:
				current_score = 21
	if abs(current_score - 21) < 7 and not wiz_animation_changed:
		print("Changing animation")
		var wiz = $Wizard
		wiz.change_animation("pondering")
		wiz_animation_changed = true
	if current_score == 21 and not first_score_reached:
		first_score_reached = true
		await get_tree().create_timer(1).timeout
		$Control/Challenge/Target.text = str(42)
		$Wizard.change_animation("evil")
		$Player.show_second_wizard_dialogue()
	if first_score_reached:
		if current_score == 42 and not second_score_reached:
			second_score_reached = true
			is_challenge_going = false
			await get_tree().create_timer(2).timeout
			$Control/Challenge/Target.text = str(128)
			$Wizard.change_animation("evil")
			$Player.show_third_wizard_dialogue()
			await get_tree().create_timer(5).timeout
			$Player.show_nuke_dialog()
			
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.name == "Player":
		if first_dialogue:
			$Player.set_can_move(false)
			print("First dialogue")
			body.show_next_wizard_dialogue(true)
			first_dialogue = false
			
func activate_challenge():
	$Control/Challenge.visible = true
	start_challenge = true
	is_challenge_going = true
	
func move_nuke():
	$Missile.position.y = target_nuke_y
	await get_tree().create_timer(1).timeout
	$Missile.rotation = 0
	$Missile.scale = Vector2(6,6)
	$Missile.play("explosion")
	await get_tree().create_timer(0.8).timeout
	$Missile.stop()
	$Missile.visible = false
	$Wizard.visible = false
	$Control.visible = false
	$Player.set_can_move(true)
	$Player/AudioStreamPlayer2D.play()
			


func _on_statue_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#$Control/StatuePanel.visible = true
		if not statue_interacted:
			$Player.set_can_move(false)
			statue_interacted = true
			body.show_statue_dialogue()
