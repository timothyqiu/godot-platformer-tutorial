extends Node

onready var animation_player = $AnimationPlayer


func reload_world():
	animation_player.play_backwards("fade-in")
	yield(animation_player, "animation_finished")
	get_tree().reload_current_scene()
	animation_player.play("fade-in")


func go_to_world(path):
	animation_player.play_backwards("fade-in")
	yield(animation_player, "animation_finished")
	get_tree().change_scene(path)
	animation_player.play("fade-in")
