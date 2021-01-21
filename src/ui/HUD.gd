extends CanvasLayer

onready var coin_label = $HBoxContainer/CoinLabel


func _ready():
	Globals.connect("coins_changed", self, "_on_coins_changed")
	coin_label.text = str(Globals.get_coins())


func _on_coins_changed():
	coin_label.text = str(Globals.get_coins())
