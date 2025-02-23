extends Node2D 

var first_dialogue = true
var can_continue = true
@onready
var player = $Player

var start_challenge = false
var current_score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_challenge:
		if Input.is_action_just_pressed("Addiction"):
			var last_roll = get_tree().get_first_node_in_group("Dice").get_last_roll()
			current_score += last_roll
		elif Input.is_action_just_pressed("Subtraction"):
			var last_roll = get_tree().get_first_node_in_group("Dice").get_last_roll()
			current_score -= last_roll
		$Control/Challenge/Current.text = str(current_score)
		


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
			
