extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _unhandled_input(event):
	print("test")
	if event.is_action_pressed("ui_cancel"):
		global.goto_scene("res://scenes/menu_levelselect.tscn")
		
	if event.is_action_pressed("ui_accept"):
		print("loading main")
		global.goto_scene("res://scenes/main.tscn")
