extends Position2D

export var enemy_scene: PackedScene
export var interval = 1.0

onready var timer = $Timer


func _ready():
	if enemy_scene:
		timer.start(interval)
		


func _on_Timer_timeout():
	var enemy: Node2D = enemy_scene.instance()
	get_parent().add_child(enemy)
	enemy.global_position = global_position
