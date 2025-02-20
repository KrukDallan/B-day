extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass#update_chunks()
	
@export var chunk_size: int = 16  # Each chunk is 16x16 tiles
@export var load_distance: int = 2  # Load chunks within 2 chunks radius
@export var unload_distance: int = 3  # Unload chunks beyond this
@onready var tile_size = 1
var active_chunks = {}

func get_chunk_coords(pos: Vector2) -> Vector2:
	return Vector2(int(pos.x / (chunk_size * tile_size)), int(pos.y / (chunk_size * tile_size)))

func update_chunks():
	var player_chunk = get_chunk_coords($Character.position)
	var chunks_to_remove = []

	# Remove distant chunks
	for chunk in active_chunks.keys():
		if chunk.distance_to(player_chunk) > unload_distance:
			chunks_to_remove.append(chunk)

	for chunk in chunks_to_remove:
		unload_chunk(chunk)

	# Load new chunks
	for x in range(-load_distance, load_distance + 1):
		for y in range(-load_distance, load_distance + 1):
			var chunk_pos = player_chunk + Vector2(x, y)
			if not active_chunks.has(chunk_pos):
				load_chunk(chunk_pos)

func load_chunk(chunk_pos: Vector2):
	# Place tiles for this chunk (similar to before, but in a chunk grid)
	active_chunks[chunk_pos] = true
	for x in range(chunk_size):
		for y in range(chunk_size):
			var tile_pos = chunk_pos * chunk_size + Vector2(int(x), int(y))
			var tile_id = 0  # You can replace this with your own logic for tiles
			$TileMap.set_cell(0, tile_pos, tile_id)

func unload_chunk(chunk_pos: Vector2):
	# Erase all tiles within this chunk
	active_chunks.erase(chunk_pos)
