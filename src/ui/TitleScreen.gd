extends Control

export var scroll_velocity = 10.0

onready var background = $DayBackground
onready var transitions = $UI/Menus/Transitions
onready var bgm_button = $UI/Menus/OptionsMenu/BGMButton
onready var sfx_button = $UI/Menus/OptionsMenu/SFXButton


func _ready():
	_update_buttons()


func _process(delta):
	background.scroll_offset.x += scroll_velocity * delta


func _on_BackButton_pressed():
	transitions.play_backwards("show-options")


func _on_OptionsButton_pressed():
	transitions.play("show-options")


func _on_BGMButton_pressed():
	Globals.bgm_enabled = not Globals.bgm_enabled
	_update_buttons()


func _on_SFXButton_pressed():
	Globals.sfx_enabled = not Globals.sfx_enabled
	_update_buttons()


func _update_buttons():
	bgm_button.text = "音乐:" + ("开" if Globals.bgm_enabled else "关")
	sfx_button.text = "音效:" + ("开" if Globals.sfx_enabled else "关")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_StartButton_pressed():
	Globals.start_game()
