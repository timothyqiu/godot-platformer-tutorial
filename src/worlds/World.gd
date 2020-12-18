extends Node2D


func _ready():
	var tilemap = $TileMap
	var camera = $Player/Camera2D
	var rect = tilemap.get_used_rect()
	camera.limit_bottom = rect.end.y * tilemap.cell_size.y
	camera.limit_left = rect.position.x * tilemap.cell_size.x
	camera.limit_right = rect.end.x * tilemap.cell_size.x


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var sfx_idx = 1
		AudioServer.set_bus_mute(sfx_idx, !AudioServer.is_bus_mute(sfx_idx))
