extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var sfx_idx = 1
		AudioServer.set_bus_mute(sfx_idx, !AudioServer.is_bus_mute(sfx_idx))
