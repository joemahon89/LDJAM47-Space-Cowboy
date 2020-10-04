extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var button1 = get_node("HBoxContainer/VBoxContainer/button1")
onready var button2 = get_node("HBoxContainer/VBoxContainer/button2")
onready var title = get_node("HBoxContainer/VBoxContainer/title_label")
onready var blurb = get_node("HBoxContainer/VBoxContainer/blurb")

var button1_target
var button2_target

# Called when the node enters the scene tree for the first time.
func _ready():
	button1.set_text(global.level_complete_settings["button1"][0])
	button2.set_text(global.level_complete_settings["button2"][0])
	title.set_text(global.level_complete_settings["title"])
	blurb.set_text(global.level_complete_settings["blurb"])
	
	button1_target = global.level_complete_settings["button1"][1]
	button2_target = global.level_complete_settings["button2"][1]
	
	button1.grab_focus()
	



func _on_button1_pressed():
	global.level_3_fail = false
	global.level_4_fail = false
	# Set the level so that global knows what to load when main loads
	global.level = global.level_complete_settings["button1"][2]
	if global.level == global.level_03:
		global.leveltimer = true
		global.leveltimer_amount = 20
	elif global.level == global.level_04:
		global.leveltimer = true
		global.leveltimer_amount = 30
	else:
		global.leveltimer = false
	global.goto_scene(button1_target)
	
func _on_button2_pressed():
	global.level = global.level_complete_settings["button2"][2]
	global.goto_scene(button2_target)
