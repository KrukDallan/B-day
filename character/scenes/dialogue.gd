extends Panel

var typing_speed = 0.05

var wizard_text: String = "I'm the Very-Well-Animated-Wizard#And you are?
#Ahh, I see, you are a loser eheheh#I bet you don't have cool animations like this one, watch!#Cool right?#
If you want to reach the statue of the goddess that lies ahead, 
you must first roll your die and reach this sum eheheh"

var wizard_text2: String = "You thought I would let you win this easily? Ehehe"
var wizard_text3: String = "Oooops, try again ehehe"
var wizard_text4: String = "...... WAIT WHAT??"

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
			var nodes = get_tree().get_nodes_in_group("Wizard")
			for node in nodes:
				node.flip()
			await get_tree().create_timer(2).timeout
		#print(next_idx, " ",len(phrase_face.keys()))
		if next_idx == len(phrase_face.keys()):
			await get_tree().create_timer(1).timeout
			visible = false	
			if map:
				map.activate_challenge()
				
func show_second_wiz_text():
	visible = true
	$Text.text = ""
	var words = wizard_text2.split(" ")
	for word in words:
		$Text.text += word + " "
		await get_tree().create_timer(typing_speed).timeout
	await get_tree().create_timer(3).timeout
	visible = false
	
func show_third_wiz_text():
	visible = true
	$Text.text = ""
	var words = wizard_text3.split(" ")
	for word in words:
		$Text.text += word + " "
		await get_tree().create_timer(typing_speed).timeout
	await get_tree().create_timer(3).timeout
	visible = false
	
func show_last_wiz_text():
	var player = get_tree().get_first_node_in_group("Player")
	player.stop_music()
	visible = true
	var nodes = get_tree().get_nodes_in_group("Wizard")
	for node in nodes:
		node.change_animation("terrified")
	$Text.text = ""
	var words = wizard_text4.split(" ")
	for word in words:
		$Text.text += word + " "
		await get_tree().create_timer(typing_speed).timeout
	await get_tree().create_timer(3).timeout
	visible = false
	for node in nodes:
		node.show_shadow()

	
func activate_dialogue():
	can_start = true
