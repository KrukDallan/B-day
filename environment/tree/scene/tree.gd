extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tree.play('default')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass#linear_velocity = Vector2(0,0)
