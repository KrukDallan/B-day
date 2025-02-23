extends Node2D 

var first_dialogue = true
var can_continue = true
@onready
var player = $Player

var start_challenge = false
var current_score: int = 0
var my_roll_id = -1
var wiz_animation_changed: bool = false

var first_score_reached = false
var second_score_reached = false
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_challenge:
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
	if abs(current_score - 21) < 5 and not wiz_animation_changed:
		print("Changing animation")
		var wiz = $Wizard
		wiz.change_animation("pondering")
		wiz_animation_changed = true
	if current_score == 21 and not first_score_reached:
		first_score_reached = true
		$Control/Challenge/Target.text = str(42)
		$Wizard.change_animation("evil")
		$Player.show_second_wizard_dialogue()
	if current_score == 42 and not second_score_reached:
		pass#$Player.stop_music()
		
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.name == "Player":
		if first_dialogue:
			print("First dialogue")
			body.show_next_wizard_dialogue(true)
			first_dialogue = false
			
func activate_challenge():
	$Control/Challenge.visible = true
	start_challenge = true
			
