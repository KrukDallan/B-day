extends Panel

signal next_phrase

var typing_speed = 0.05

var wizard_text: String = "Eheheheh#I'm the very-well-animated-wizard#And you are?
#Ahh I see, you are a loser eheheh#I bet you don't have cool animations like this one, watch!#
If you want to reach the statue of the goddess that lies ahead, 
you must first roll your die and reach this sum eheheh"

var phrase_face: Dictionary = {}
var phrases: Array = []
var faces = ["evil","happy","happy","evil","evil","evil"]
var next_idx = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Text.text = ""
	phrases = wizard_text.split("#")
	#print(phrases)
	for i in range(len(phrases)):
		phrase_face[phrases[i].strip_escapes()] = faces[i]
	#print(phrase_face)
	
	#await get_tree().create_timer(1).timeout
	#show_text(full_text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
		if next_idx == 5:
			var node = get_tree().get_nodes_in_group("Wizard")[0]
			print(node, " is going to flip")
			await node.flipped
			print("Flipped")
