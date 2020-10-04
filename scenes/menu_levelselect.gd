extends Control


var button_tutorial
var button_level_01
var button_level_02
var button_level_03
var button_level_04
var button_level_05


# Called when the node enters the scene tree for the first time.
func _ready():
	button_tutorial = get_node("HBoxContainer/VBoxContainer/button_tutorial")
	button_level_01 = get_node("HBoxContainer/VBoxContainer/button_level_01")
	button_level_02 = get_node("HBoxContainer/VBoxContainer/button_level_02")
	button_level_03 = get_node("HBoxContainer/VBoxContainer/button_level_03")
	button_level_04 = get_node("HBoxContainer/VBoxContainer/button_level_04")
	button_level_05 = get_node("HBoxContainer/VBoxContainer/button_level_05")
	
	# Set button focuses
	if global.level == global.tutorial:
		button_tutorial.grab_focus()
	elif global.level == global.level_01:
		button_level_01.grab_focus()
	elif global.level == global.level_02:
		button_level_02.grab_focus()
	elif global.level == global.level_03:
		button_level_03.grab_focus()
	elif global.level == global.level_04:
		button_level_04.grab_focus()
	elif global.level == global.level_05:
		button_level_05.grab_focus()
		
		
	# Set 'completed' to buttons if the levels have been completed
	if global.levels_complete["tutorial"] == 1:
		button_tutorial.text = "TUTORIAL" + " - COMPLETED!"
	if global.levels_complete["level1"] == 1:
		button_tutorial.text = "Level 1" + " - COMPLETED!"
	if global.levels_complete["level2"] == 1:
		button_tutorial.text = "Level 2" + " - COMPLETED!"
	if global.levels_complete["level3"] == 1:
		button_tutorial.text = "Level 3" + " - COMPLETED!"
	if global.levels_complete["level4"] == 1:
		button_tutorial.text = "Level 4" + " - COMPLETED!"
	if global.levels_complete["level5"] == 1:
		button_tutorial.text = "Level 5" + " - COMPLETED!"
		

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
