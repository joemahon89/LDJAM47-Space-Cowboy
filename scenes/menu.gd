extends Control


func _ready():
	pass # Replace with function body.



func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		AudioStreamManager.play("res://sounds/menu_select.wav")
		global.goto_scene("res://scenes/menu_levelselect.tscn")
