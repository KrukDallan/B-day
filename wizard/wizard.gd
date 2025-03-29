extends AnimatedSprite2D

signal flipped

var has_flipped = false
var max_scale = 8
var enlarge_shadow = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enlarge_shadow:
		if $Shadow.scale[0] < max_scale:
			$Shadow.scale[0] += 0.015
			$Shadow.scale[1] += 0.015
		if $Shadow.scale[0] >= max_scale:
			print("Moving nuke")
			enlarge_shadow = false
			var node = get_tree().get_first_node_in_group("Map")
			node.move_nuke()
			
func change_animation(anim_name:String):
	self.play(anim_name)
	
func flip():
	if true:#not has_flipped:
		has_flipped = true
		await get_tree().create_timer(0.5).timeout
		print("Flippin")
		self.flip_h = true
		await get_tree().create_timer(0.5).timeout
		self.flip_h = false
		flipped.emit()
		
func show_shadow():
	$Shadow.visible = true
	enlarge_shadow = true
