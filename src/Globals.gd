extends Node

const BGM_IDX = 1
const SFX_IDX = 2

var bgm_enabled setget set_bgm_enabled, is_bgm_enabled
var sfx_enabled setget set_sfx_enabled, is_sfx_enabled

onready var animation_player = $AnimationPlayer


func back_to_title():
	go_to_world("res://src/ui/TitleScreen.tscn")


func start_game():
	go_to_world("res://src/worlds/World01.tscn")


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


func is_bgm_enabled():
	return not AudioServer.is_bus_mute(BGM_IDX)


func set_bgm_enabled(value):
	AudioServer.set_bus_mute(BGM_IDX, not value)


func is_sfx_enabled():
	return not AudioServer.is_bus_mute(SFX_IDX)


func set_sfx_enabled(value):
	AudioServer.set_bus_mute(SFX_IDX, not value)
