extends "res://src/enemies/Enemy.gd"

enum Direction { LEFT = -1, RIGHT = 1 }

export(Direction) var direction = Direction.LEFT


func _physics_process(delta):
	var was_on_wall = is_on_wall()
	var snap = Vector2.DOWN * 16
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	
	if is_on_wall() and not was_on_wall:
		direction *= -1


func _process(delta):
	if is_dead:
		velocity.x = 0
	else:
		velocity.x = move_toward(velocity.x, max_speed * direction, acceleration * delta)
	velocity.y += gravity * delta
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x > 0
