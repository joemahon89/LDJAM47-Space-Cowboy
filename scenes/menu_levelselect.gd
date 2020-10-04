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
	

		
	# Set disabled if not unlocked
	#if global.levels_complete["tutorial"]:
		
	#if global.levels_complete["level1"]
	

		
	
		
		
	# Set 'completed' to buttons if the levels have been completed
	if global.levels_complete["tutorial"] == 1:
		button_tutorial.text = "TUTORIAL" + " - COMPLETED!"
	if global.levels_complete["level1"] == 1:
		button_level_01.text = "Level 1" + " - COMPLETED!"
		button_level_02.focus_mode = FOCUS_ALL
		button_level_02.disabled = false
	if global.levels_complete["level2"] == 1:
		button_level_02.text = "Level 2" + " - COMPLETED!"
		button_level_03.focus_mode = FOCUS_ALL
		button_level_03.disabled = false
	if global.levels_complete["level3"] == 1:
		button_level_03.text = "Level 3" + " - COMPLETED!"
		button_level_04.focus_mode = FOCUS_ALL
		button_level_04.disabled = false
	if global.levels_complete["level4"] == 1:
		button_level_04.text = "Level 4" + " - COMPLETED!"
		button_level_05.focus_mode = FOCUS_ALL
		button_level_05.disabled = false
	if global.levels_complete["level5"] == 1:
		button_level_05.text = "Level 5" + " - COMPLETED!"
		
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
		
		
	var debug = true
	if debug == true:
		button_level_02.focus_mode = FOCUS_ALL
		button_level_02.disabled = false
		button_level_03.focus_mode = FOCUS_ALL
		button_level_03.disabled = false
		button_level_04.focus_mode = FOCUS_ALL
		button_level_04.disabled = false
		button_level_05.focus_mode = FOCUS_ALL
		button_level_05.disabled = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		global.goto_scene("res://scenes/menu.tscn")


func _on_button_tutorial_pressed():
	global.level = global.tutorial
	global.leveltimer = false
	global.goto_scene(global.tutorial_scene)


func _on_button_level_01_pressed():
	global.level = global.level_01
	global.leveltimer = false
	global.goto_scene(global.level_1_scene)


func _on_button_level_02_pressed():
	global.level = global.level_02
	global.leveltimer = false
	global.goto_scene(global.level_2_scene)


func _on_button_level_03_pressed():
	global.level = global.level_03
	global.leveltimer = true
	global.goto_scene(global.level_3_scene)


func _on_button_level_04_pressed():
	global.level = global.level_04
	global.leveltimer = false
	global.goto_scene(global.level_4_scene)


func _on_button_level_05_pressed():
	global.level = global.level_05
	global.leveltimer = false
	global.goto_scene(global.level_5_scene)
