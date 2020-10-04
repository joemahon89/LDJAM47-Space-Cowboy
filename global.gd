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

var level_01 = {"creature_02":8}
var level_02 = {"creature_01":5,
				"creature_03":25,
				}

var level_03 = {"creature_04":3,}

var level_04 = {"creature_05":20,}

var level_05 = {"creature_01":2,
				"creature_02":2}

var tutorial_scene = "res://scenes/menu_tutorial.tscn"
var level_1_scene = "res://scenes/menu_level1.tscn"
var level_2_scene = "res://scenes/menu_level2.tscn"
var level_3_scene = "res://scenes/menu_level3.tscn"
var level_4_scene = "res://scenes/menu_level4.tscn"
var level_5_scene = "res://scenes/menu_level5.tscn"
var creature_handbook_scene = "res://scenes/creature_handbook.tscn"


var total_cash = 0
var level = tutorial
var leveltimer = false
var leveltimer_amount = 20
var points = 0

var captured_creatures = []
var lasso_casts = 0

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

# Manual fail states for setting (eg level 3 timer)
var level_3_fail = false
var level_4_fail = false

func level_win_state_check():
	# TUTORIAL WIN STATE
	if level == tutorial:
		# win when a single cow has been caught
		if len(captured_creatures) > 0:
			AudioStreamManager.play("res://sounds/level_success.wav")
			captured_creatures = []
			levels_complete["tutorial"] = 1
			level_complete_settings["title"] = "Tutorial Complete"
			level_complete_settings["blurb"] = "Well done on catching a FLUMBER!"
			level_complete_settings["button1"] = ["NEXT LEVEL", level_1_scene, level_01]
			level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_01]
			end_level()
		# No fail state for tutorial
		else:
			pass

	# LEVEL 1 WIN STATE
	if level == level_01:
		# Win when a pikka (creatue2) has beenn caught with only 5 lasso throws
		if lasso_casts < 6:
			if len(captured_creatures) >= 2:
				captured_creatures = []
				AudioStreamManager.play("res://sounds/level_success.wav")
				levels_complete["level1"] = 1
				level_complete_settings["title"] = "Level 1 Complete"
				level_complete_settings["blurb"] = "Well done for catching a PIKKA in under 5 loop throws!"
				level_complete_settings["button1"] = ["NEXT LEVEL", level_2_scene, level_02]
				level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_02]
				end_level()
		else:
			# Fail, too many lasso attempts
			AudioStreamManager.play("res://sounds/level_fail.wav")
			captured_creatures = []
			level_complete_settings["title"] = "Level 1 Failed"
			level_complete_settings["blurb"] = "Oh no, you ran out of loops!"
			level_complete_settings["button1"] = ["TRY AGAIN", level_1_scene, level_01]
			level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_01]
			end_level()
	
	# LEVEL 2 WIN STATE
	if level == level_02:
		# Captured the whole herd
		if len(captured_creatures) == level_02["creature_01"]:
			AudioStreamManager.play("res://sounds/level_success.wav")
			captured_creatures = []
			levels_complete["level2"] = 1
			level_complete_settings["title"] = "Level 2 Complete"
			level_complete_settings["blurb"] = "Your herd of FLUMBERs is safe from the SPACE CRABS!"
			level_complete_settings["button1"] = ["NEXT LEVEL", level_3_scene, level_03]
			level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_03]
			end_level()
		# lassoed a crab, fail level
		if current_captured:
			AudioStreamManager.play("res://sounds/level_fail.wav")
			if current_captured.creature_type == "creature_03":
				captured_creatures = []
				level_complete_settings["title"] = "Level 2 Failed"
				level_complete_settings["blurb"] = "Oh no, you caught a SPACE CRAB and it bit through your loop!"
				level_complete_settings["button1"] = ["TRY AGAIN", level_2_scene, level_02]
				level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_02]
				end_level()
		
	# LEVEL 3 WIN STATE
	if level == level_03:
		if level_3_fail == false:
			# Captured within time limit
			if len(captured_creatures) == level_03["creature_04"]:
				AudioStreamManager.play("res://sounds/level_success.wav")
				captured_creatures = []
				levels_complete["level3"] = 1
				level_complete_settings["title"] = "Level 3 Complete"
				level_complete_settings["blurb"] = "Thats the fastest those lazy BLUBBERBOBS have ever had to travel!"
				level_complete_settings["button1"] = ["NEXT LEVEL", level_4_scene, level_04]
				level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_04]
				end_level()
		elif level_3_fail == true:
			# ran out of time
			AudioStreamManager.play("res://sounds/level_fail.wav")
			captured_creatures = []
			level_complete_settings["title"] = "Level 3 Failed"
			level_complete_settings["blurb"] = "Oh no, you didn't get them all inside in time!"
			level_complete_settings["button1"] = ["TRY AGAIN", level_3_scene, level_03]
			level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_03]
			end_level()

	# LEVEL 4 WIN STATE
	if level == level_04:
		if level_4_fail == false:
			# Captured within time limit
			if len(captured_creatures) >= 4:
				AudioStreamManager.play("res://sounds/level_success.wav")
				captured_creatures = []
				levels_complete["level4"] = 1
				level_complete_settings["title"] = "Game Complete!"
				level_complete_settings["blurb"] = "Congratulations! You have completed the game! Thank you for playing :)"
				#level_complete_settings["button1"] = ["NEXT LEVEL", level_5_scene, level_05]
				level_complete_settings["button1"].set_visible(false)
				level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_05]
				end_level()
		elif level_4_fail == true:
			# ran out of time
			AudioStreamManager.play("res://sounds/level_fail.wav")
			captured_creatures = []
			level_complete_settings["title"] = "Level 4 Failed"
			level_complete_settings["blurb"] = "Looks like those GROGSNIPPERS were too much to handle!"
			level_complete_settings["button1"] = ["TRY AGAIN", level_4_scene, level_04]
			level_complete_settings["button2"] = ["QUIT TO MENU", "res://scenes/menu_levelselect.tscn", level_04]
			end_level()



func end_level():
	global.goto_scene("res://scenes/level_complete.tscn")



#func end_level(success_or_fail):
#	if success_or_fail == "success":
#		print("success")
#		global.goto_scene("res://scenes/level_complete.tscn")
#	elif success_or_fail == "fail":
#		print("fail")
#		global.goto_scene("res://scenes/level_complete.tscn")
		


var rope_sound = "res://sounds/rope.wav"
var stream
var music_player

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





