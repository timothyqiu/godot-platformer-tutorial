extends Control

export var scroll_velocity = 10.0

onready var background = $DayBackground


func _process(delta):
	background.scroll_offset.x += scroll_velocity * delta
