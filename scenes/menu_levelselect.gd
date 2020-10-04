extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set button focuses
	if global.level == global.tutorial:
		get_node("HBoxContainer/VBoxContainer/button_tutorial").grab_focus()
	elif global.level == global.level_01:
		get_node("HBoxContainer/VBoxContainer/button_level_01").grab_focus()
	elif global.level == global.level_02:
		get_node("HBoxContainer/VBoxContainer/button_level_02").grab_focus()
	elif global.level == global.level_03:
		get_node("HBoxContainer/VBoxContainer/button_level_03").grab_focus()
	elif global.level == global.level_04:
		get_node("HBoxContainer/VBoxContainer/button_level_04").grab_focus()
	elif global.level == global.level_05:
		get_node("HBoxContainer/VBoxContainer/button_level_05").grab_focus()
		

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		global.goto_scene("res://scenes/menu.tscn")


func _on_button_tutorial_pressed():
	global.level = global.tutorial
	global.goto_scene("res://scenes/menu_tutorial.tscn")


func _on_button_level_01_pressed():
	global.level = global.level_01
	global.goto_scene("res://scenes/menu_level1.tscn")


func _on_button_level_02_pressed():
	global.level = global.level_02
	global.goto_scene("res://scenes/menu_level2.tscn")


func _on_button_level_03_pressed():
	global.level = global.level_03
	global.goto_scene("res://scenes/menu_level3.tscn")


func _on_button_level_04_pressed():
	global.level = global.level_04
	global.goto_scene("res://scenes/menu_level4.tscn")


func _on_button_level_05_pressed():
	global.level = global.level_05
	global.goto_scene("res://scenes/menu_level5.tscn")
