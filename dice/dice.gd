extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
var has_rolled = false
var can_roll = true
var number_got = 0
var roll_id = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	if Input.is_key_pressed(KEY_R) and can_roll:
		can_roll = false
		can_roll = await roll_die()
			
func roll_die():
	self.speed_scale = 4
	self.play("roll")
	has_rolled = true
	await get_tree().create_timer(1.0).timeout
	self.stop()
	self.speed_scale = 1
	var idx = rng.randi_range(1,6)
	number_got = idx
	self.animation = str(idx) 
	roll_id += 1
	return true
	
func get_last_roll():
	return number_got

func get_roll_id():
	return roll_id
			
