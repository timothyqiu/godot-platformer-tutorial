extends "res://src/enemies/Enemy.gd"

var target_position = null

onready var player_sensor = $PlayerSensor


func _process(delta):
	if is_dead:
		velocity.x = 0
		velocity.y += gravity * delta
	else:
		target_position = _calc_target_position()
		if target_position == null:
			velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
		else:
			var direction = global_position.direction_to(target_position)
			velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
			sprite.flip_h = direction.x > 0


func _physics_process(delta):
	velocity = move_and_slide(velocity)


func _calc_target_position():
	var bodies = player_sensor.get_overlapping_bodies()
	if not bodies.empty():
		return bodies[0].global_position + Vector2(0, -50)
	
	if target_position != null and global_position.distance_squared_to(target_position) < 25:
		return null
	
	return target_position


