extends AudioStreamPlayer


func _ready():
	_hook_button_sound(get_parent())


func _hook_button_sound(node):
	for child in node.get_children():
		if child is Button:
			child.connect("pressed", self, "play")
		else:
			_hook_button_sound(child)
