extends Area2D

signal hit


func _on_Hitbox_area_entered(hurtbox):
	emit_signal("hit")
	hurtbox.emit_signal("hurt")
