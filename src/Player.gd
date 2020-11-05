extends KinematicBody2D

const gravity = 2000
const max_speed = 350
const acceleration = max_speed / 0.2
const air_acceleration = max_speed / 0.05
const jump_force = 800

var velocity = Vector2.ZERO
var is_jumping = false

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var coyote_timer = $CoyoteTimer
onready var jump_request_timer = $JumpRequestTimer


func _physics_process(delta):
	var was_on_floor = is_on_floor()
	
	var snap = Vector2.ZERO if is_jumping else Vector2.DOWN * 16
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	if is_on_floor():
		is_jumping = false
	elif was_on_floor and not is_jumping:
		coyote_timer.start()


func _input(event):
	if event.is_action_pressed("jump"):
		jump_request_timer.start()
	if event.is_action_released("jump") and velocity.y < -jump_force / 2:
		velocity.y = -jump_force / 2


func _process(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	var acc = acceleration if is_on_floor() else air_acceleration
	velocity.x = move_toward(velocity.x, direction * max_speed, acc * delta)
	velocity.y += gravity * delta
	
	var can_jump = is_on_floor() or coyote_timer.time_left > 0
	if can_jump and jump_request_timer.time_left > 0:
		velocity.y = -jump_force
		is_jumping = true
		jump_request_timer.stop()
		coyote_timer.stop()
	
	if is_jumping:
		animation_player.play("jump")
	elif velocity.x == 0:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
	
	if direction != 0:
		sprite.flip_h = direction < 0


func _on_Hurtbox_hurt():
	get_tree().reload_current_scene()


func _on_Hitbox_hit():
	velocity.y = -jump_force / 2
