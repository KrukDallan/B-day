extends Node2D
var first_dialogue = true
var can_continue = true
@onready
var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		player.continue_dialogue.connect(prova)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Enter") and not first_dialogue:
		print("Map before calling dialogue")
		$Player.show_next_wizard_dialogue()
		print("Map after calling dialogue")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.name == "Player":
		if first_dialogue:
			print("First dialogue")
			body.show_next_wizard_dialogue(true)
			first_dialogue = false
			
func prova():
	print("Signal received")
	can_continue = true
	if can_continue and not first_dialogue:
		can_continue = false
		print("Map before calling dialogue")
		$Player.show_next_wizard_dialogue()
		print("Map after calling dialogue")
			
