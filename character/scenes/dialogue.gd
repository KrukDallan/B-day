extends Panel

var typing_speed = 0.05

var wizard_text: String = "I'm the very-well-animated-wizard#And you are?
#Ahh I see, you are a loser eheheh#I bet you don't have cool animations like this one, watch!#Cool right?#
If you want to reach the statue of the goddess that lies ahead, 
you must first roll your die and reach this sum eheheh"

var phrase_face: Dictionary = {}
var phrases: Array = []
var faces = ["evil","happy","evil","evil","evil","evil"]
var next_idx = 0

var can_start = false
var can_continue = true

var map 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Text.text = "Eheheheh"
	phrases = wizard_text.split("#")
	#print(phrases)
	for i in range(len(phrases)):
		phrase_face[phrases[i].strip_escapes()] = faces[i]
	
	map = get_tree().get_first_node_in_group("Map")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_start:
		if can_continue:
			if Input.is_action_just_pressed("Enter"):
				can_continue = false
				await show_text()
				can_continue = true


func show_text():
	if next_idx < len(phrase_face.keys()):
		$Text.text = ""
		var phrase = phrase_face.keys()[next_idx]
		var face = phrase_face[phrase]
		for node in get_tree().get_nodes_in_group("Wizard"):
			node.change_animation(face)
		next_idx += 1
		var words = phrase.split(" ")
		for word in words:
			$Text.text += word + " "
			await get_tree().create_timer(typing_speed).timeout
		await get_tree().create_timer(1).timeout
		if next_idx == 4:
			var node = get_tree().get_nodes_in_group("Wizard")[0]
			node.flip()
			await get_tree().create_timer(2).timeout
		print(next_idx, " ",len(phrase_face.keys()))
		if next_idx == len(phrase_face.keys()):
			await get_tree().create_timer(2).timeout
			visible = false	
			if map:
				map.activate_challenge()
			
func activate_dialogue():
	can_start = true
