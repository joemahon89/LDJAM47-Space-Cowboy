extends Control


func _ready():
	pass # Replace with function body.



func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		global.goto_scene("res://scenes/menu_levelselect.tscn")
