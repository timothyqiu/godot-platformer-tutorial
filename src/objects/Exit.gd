extends Area2D

export(String, FILE, "*.tscn") var path


func _on_Exit_body_entered(_player):
	Globals.go_to_world(path)
