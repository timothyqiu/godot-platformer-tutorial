extends KinematicBody2D

const gravity = 2000

export var max_speed = 50
export var acceleration = 50 / 0.2
export var is_dead = false

var velocity := Vector2.ZERO

onready var sprite: Sprite = $Sprite
onready var animation_player = $AnimationPlayer


func _on_Hurtbox_hurt():
	if animation_player.has_animation("death"):
		animation_player.play("death")
	else:
		queue_free()
