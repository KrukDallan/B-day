extends Panel


var typing_speed = 0.01
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Nuke"):
		visible = false
		var nodes = get_tree().get_nodes_in_group("Wizard")
		for node in nodes:
			node.change_animation("terrified")
		var node = get_tree().get_first_node_in_group("Dialogue")
		node.show_last_wiz_text()
		

func show_text(new_text: String):
	$Text.text = ""
	visible = true
	var words = new_text.split(" ")
	for i in words:
		$Text.text += i + " "
		await get_tree().create_timer(typing_speed).timeout
	
		
