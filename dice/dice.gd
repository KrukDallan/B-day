extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
var has_rolled = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Timer.time_left <= 0.0 and not has_rolled:
		roll_die()
		
	if has_rolled:
		if Input.is_key_pressed(KEY_R):
			roll_die()
			
func roll_die():
	self.speed_scale = 4
	self.play("roll")
	has_rolled = true
	await get_tree().create_timer(1.0).timeout
	self.stop()
	self.speed_scale = 1
	var idx = rng.randi_range(1,6)
	self.animation = str(idx) 
			
