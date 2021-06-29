extends Node2D

onready var tilemap = $TileMap


func _ready():
	var rect = tilemap.get_used_rect()
	
	var bounds = Rect2(
		rect.position.x * tilemap.cell_size.x,
		rect.position.y * tilemap.cell_size.y,
		rect.size.x * tilemap.cell_size.x,
		rect.size.y * tilemap.cell_size.y
	)
	
	var camera = $Player/Camera2D
	camera.limit_bottom = bounds.end.y
	camera.limit_left = bounds.position.x
	camera.limit_right = bounds.end.x
	
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(bounds.size.x / 2, tilemap.cell_size.y / 2)
	$Hitbox/CollisionShape2D.shape = shape
	$Hitbox.position = Vector2(
		bounds.position.x + bounds.size.x / 2,
		bounds.end.y + tilemap.cell_size.y * 2
	)
	
	add_child(preload("res://src/ui/HUD.tscn").instance())
	
	instance_tiles("coin", preload("res://src/Coin.tscn"))


func instance_tiles(tile_name, scene):
	var id = tilemap.tile_set.find_tile_by_name(tile_name)
	assert(id != -1)
	
	for pos in tilemap.get_used_cells_by_id(id):
		var node = scene.instance()
		tilemap.add_child(node)
		node.position = tilemap.map_to_world(pos) + tilemap.cell_size / 2
		tilemap.set_cellv(pos, -1)






