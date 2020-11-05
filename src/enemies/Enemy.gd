extends KinematicBody2D

const gravity = 2000

onready var sprite: Sprite = $Sprite
onready var animation_player = $AnimationPlayer


func _on_Hurtbox_hurt():
	if animation_player.has_animation("death"):
		animation_player.play("death")
	else:
		queue_free()
