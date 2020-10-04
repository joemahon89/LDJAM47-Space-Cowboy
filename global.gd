extends Node



var current_captured = null

var main_node
var score_counter


# Scene switching
var current_scene = null
#var current_level = "tutorial"

var levels_complete = {
						"tutorial":0,
						"level1":0,
						"level2":0,
						"level3":0,
						"level4":0,
						"level5":0,
						}

var tutorial = {"creature_01":5}

var level_01 = {"creature_01":40,
				"creature_02":1}
				
var level_02 = {"creature_01":2,
				"creature_02":2}

var level_03 = {"creature_01":2,
				"creature_02":2}

var level_04 = {"creature_01":2,
				"creature_02":2}

var level_05 = {"creature_01":2,
				"creature_02":2}

var tutorial_scene = "res://scenes/menu_tutorial.tscn"
var level_1_scene = "res://scenes/menu_level1.tscn"
var level_2_scene = "res://scenes/menu_level2.tscn"
var level_3_scene = "res://scenes/menu_level3.tscn"
var level_4_scene = "res://scenes/menu_level4.tscn"
var level_5_scene = "res://scenes/menu_level5.tscn"


var total_cash = 0
var level = tutorial

var points = 0

var captured_creatures = []

func add_points(points_to_add):
	main_node = get_tree().get_root().get_node("Node2D")
	score_counter = main_node.get_node("score_counter")
	points += points_to_add
	score_counter.set_text(str(points))
	#score_counter.set_text("%05d" % points)
	# CHeck whether this has resulted in a win
	level_win_state_check()
	pass

var level_complete_settings = {
								"title":"none",
								"blurb":"none",
								"button1":"none",
								"button2":"none",
								}




func level_win_state_check():
	if level == tutorial:
		# win when a single cow has been caught
		if len(captured_creatures) > 0:
			captured_creatures = []
			levels_complete["tutorial"] = 1
			level_complete_settings["title"] = "Tutorial Complete"
			level_complete_settings["blurb"] = "Well done on catching a FLUMBER!"
			level_complete_settings["button1"] = ["NEXT LEVEL", level_1_scene, level_01]
			level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_01]
			end_level("success")
		# No fail state for tutorial
		else:
			pass


func end_level(success_or_fail):
	if success_or_fail == "success":
		print("success")
		global.goto_scene("res://scenes/level_complete.tscn")
	elif success_or_fail == "fail":
		print("fail")
		global.goto_scene("res://scenes/level_complete.tscn")
		

func _ready():
	OS.window_size = Vector2(720,720)
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)


