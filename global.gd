extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var current_captured = null

onready var main_node = get_tree().get_root().get_node("Node2D")
onready var score_counter = main_node.get_node("score_counter")

var level_01 = {"creature_01":40,
				"creature_02":1}
				
var level_02 = {"creature_01":2,
				"creature_02":2}

var total_cash = 0
var level = level_01

var points = 0

func add_points(points_to_add):
	points += points_to_add
	score_counter.set_text(str(points))
	#score_counter.set_text("%05d" % points)
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
