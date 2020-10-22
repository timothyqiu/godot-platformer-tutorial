extends Area2D




func _on_Coin_body_entered(_player):
	$AnimationPlayer.play("picked")
