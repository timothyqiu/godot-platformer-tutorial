extends "res://src/enemies/Enemy.gd"

enum Direction { LEFT = -1, RIGHT = 1 }

const max_speed = 50
const acceleration = max_speed / 0.2

export(Direction) var direction = Direction.LEFT

var velocity = Vector2.ZERO


func _physics_process(delta):
	var was_on_wall = is_on_wall()
	var snap = Vector2.DOWN * 16
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	
	if is_on_wall() and not was_on_wall:
		direction *= -1


func _process(delta):
	velocity.x = move_toward(velocity.x, max_speed * direction, acceleration * delta)
	velocity.y += gravity * delta
	
	sprite.flip_h = velocity.x > 0
