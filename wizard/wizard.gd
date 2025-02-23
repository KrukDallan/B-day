extends AnimatedSprite2D

signal flipped

var has_flipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
