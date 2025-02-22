extends StaticBody2D

var pressed = false
var is_player_nearby = false
var is_open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Roll") and is_player_nearby:
		await get_tree().create_timer(1.5).timeout
		var dice = get_tree().get_nodes_in_group("Dice")
		var number = dice[0].get_last_roll()
		print(number)
		if number %2 == 0:
			$Door.play("open")
			$ClosedCS.disabled = true
			$Message.visible = false
			is_open = true


func _on_approach_area_body_entered(body: Node2D) -> void:
	print(body.name)
	if not is_open and body.name != "Door":
		$Message.visible = true
		is_player_nearby = true


func _on_approach_area_body_exited(body: Node2D) -> void:
	$Message.visible = false
	is_player_nearby = false
