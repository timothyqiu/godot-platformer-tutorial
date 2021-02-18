extends Control

onready var time_value = $UI/Stats/TimeValue
onready var deaths_value = $UI/Stats/DeathsValue
onready var coins_value = $UI/Stats/CoinsValue


func _ready():
	var duration = Globals.completed_at - Globals.started_at
	var minutes = duration / 60
	var seconds = duration % 60
	time_value.text = "%d:%02d" % [minutes, seconds]
	deaths_value.text = str(Globals.deaths)
	coins_value.text = str(Globals.get_coins())


func _input(event):
	if event.is_pressed():
		Globals.back_to_title()
