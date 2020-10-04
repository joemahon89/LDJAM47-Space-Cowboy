extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		AudioStreamManager.play("res://sounds/menu_back.wav")
		global.goto_scene("res://scenes/menu_levelselect.tscn")
		


