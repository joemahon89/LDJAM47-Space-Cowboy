extends Node2D



onready var lasso_join_point_node = get_node("YSort/lasso/lasso_sprite/lasso_join_point")
onready var lasso_node = get_node("YSort/lasso")
onready var lasso_anchor_point_node = get_node("lasso_anchor_point")
onready var lasso_rope_node = get_node("lasso_rope")
onready var creature_scene = preload("res://scenes/creature_01.tscn")
onready var ysort_node = get_node("YSort")




# Spawn area for creatures
var spawn_area_x_min = 24
var spawn_area_x_max = 336
var spawn_area_y_min = 24
var spawn_area_y_max = 224



# Called when the node enters the scene tree for the first time.
func _ready():
	lasso_node.input_allowed = false
	#OS.window_size = Vector2(360,360)
	intialise_creatures()
	#lasso_node.reset_lasso()


func intialise_creatures():
	randomize()
	for creature_type in global.level.keys():
		var number_of_this_creature_type = global.level[creature_type]
		for each_creature in range(0,number_of_this_creature_type):
			var creature_instance = creature_scene.instance()
			var random_spawn_point = Vector2(
											(randi() % (spawn_area_x_max - spawn_area_x_min) + spawn_area_x_min),
											(randi() % (spawn_area_y_max - spawn_area_y_min) + spawn_area_y_min)
											)
			creature_instance.position = random_spawn_point
			creature_instance.creature_type = creature_type
			ysort_node.add_child(creature_instance)	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
