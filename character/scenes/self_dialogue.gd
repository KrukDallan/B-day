extends Panel


var typing_speed = 0.03
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_text(new_text: String):
	$Text.text = ""
	var words = new_text.split(" ")
	for i in words:
		$Text.text += i + " "
		await get_tree().create_timer(typing_speed).timeout
