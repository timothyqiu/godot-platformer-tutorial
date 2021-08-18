extends KinematicBody2D

const gravity = 2000
const max_speed = 350
const acceleration = max_speed / 0.2
const air_acceleration = max_speed / 0.05
const jump_force = 880

export var is_dead = false

var velocity = Vector2.ZERO
var is_jumping = false

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var coyote_timer = $CoyoteTimer
onready var jump_request_timer = $JumpRequestTimer
onready var jump_sound = $JumpSound
onready var tween = $Tween


func _physics_process(delta):
	var was_on_floor = is_on_floor()
	
	var snap = Vector2.ZERO if is_jumping else Vector2.DOWN * 16
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	if is_on_floor():
		is_jumping = false
		if not was_on_floor:
			_tween_scale(Vector2(1.25, 1/1.25))
	elif was_on_floor and not is_jumping:
		coyote_timer.start()


func _unhandled_input(event):
	if is_dead:
		return
	if event.is_action_pressed("jump"):
		jump_request_timer.start()
	if event.is_action_released("jump") and velocity.y < -jump_force / 2:
		velocity.y = -jump_force / 2


func _process(delta):
	velocity.y += gravity * delta
	
	if is_dead:
		return
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	var acc = acceleration if is_on_floor() else air_acceleration
	velocity.x = move_toward(velocity.x, direction * max_speed, acc * delta)
	
	var can_jump = is_on_floor() or coyote_timer.time_left > 0
	if can_jump and jump_request_timer.time_left > 0:
		velocity.y = -jump_force
		is_jumping = true
		jump_request_timer.stop()
		coyote_timer.stop()
		jump_sound.play()
		_tween_scale(Vector2(1/1.25, 1.25))
	
	if is_jumping:
		animation_player.play("jump")
	elif velocity.x == 0:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
	
	if direction != 0:
		sprite.flip_h = direction < 0


func _tween_scale(target):
	tween.interpolate_property(
		sprite, "scale", null, target, 0.05,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		sprite, "scale", target, Vector2.ONE, 0.1,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT,
		0.05
	)
	tween.start()


func _on_Hurtbox_hurt(_hitbox):
	velocity.y = -jump_force
	animation_player.play("death")
	Globals.reload_world()


func _on_Hitbox_hit():
	velocity.y = -jump_force / 2
	if not is_on_floor():
		_tween_scale(Vector2(1.25, 1/1.25))


func _on_TrailTimer_timeout():
	if velocity.x == 0:
		return
	
	var trail = preload("res://src/effects/Trail.tscn").instance()
	get_parent().add_child(trail)
	get_parent().move_child(trail, get_index())
	
	var properties = [
		"hframes",
		"vframes",
		"frame",
		"texture",
		"global_position",
		"flip_h",
	]
	for name in properties:
		trail.set(name, sprite.get(name))
