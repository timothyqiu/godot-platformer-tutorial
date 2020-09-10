extends KinematicBody2D

const gravity = 2000
const speed = 350
const jump_force = 800

var velocity = Vector2.ZERO
var is_jumping = false

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		is_jumping = false


func _input(event):
	if event.is_action_pressed("jump") and not is_jumping:
		velocity.y = -jump_force
		is_jumping = true


func _process(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction * speed
	velocity.y += gravity * delta
	
	if is_jumping:
		animation_player.play("jump")
	elif direction == 0:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
	
	if direction != 0:
		sprite.flip_h = direction < 0
