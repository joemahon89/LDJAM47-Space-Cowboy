extends Node



var current_captured = null

var main_node
var score_counter


var level_01 = {"creature_01":40,
				"creature_02":1}
				
var level_02 = {"creature_01":2,
				"creature_02":2}

var total_cash = 0
var level = level_01

var points = 0

func add_points(points_to_add):
	main_node = get_tree().get_root().get_node("Node2D")
	score_counter = main_node.get_node("score_counter")
	points += points_to_add
	score_counter.set_text(str(points))
	#score_counter.set_text("%05d" % points)
	pass


# Scene switching
var current_scene = null

func _ready():
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


