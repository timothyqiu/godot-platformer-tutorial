extends Control

onready var transitions = $Transitions


func show_menu():
	show()
	transitions.play("show")


func hide_menu():
	transitions.play_backwards("show")
	yield(transitions, "animation_finished")
	hide()


func _unhandled_input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		hide_menu()
		get_tree().set_input_as_handled()


func _on_ResumeButton_pressed():
	hide_menu()


func _on_QuitButton_pressed():
	hide_menu()
	Globals.back_to_title()


func _on_PauseMenu_visibility_changed():
	get_tree().paused = visible
