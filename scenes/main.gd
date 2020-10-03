extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lasso_join_point_node = get_node("YSort/lasso/lasso_sprite/lasso_join_point")
onready var lasso_node = get_node("YSort/lasso")
onready var lasso_anchor_point_node = get_node("lasso_anchor_point")
onready var lasso_rope_node = get_node("lasso_rope")

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_size = Vector2(720,720)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#lasso_rope_node.points = [Vector2(0,0), Vector2(0,0)]
	lasso_rope_node.points[0] = lasso_anchor_point_node.position
	lasso_rope_node.points[1] = lasso_join_point_node.get_global_position()
	#lasso_rope_node.points[1] = lasso_join_point_node.position + lasso_node.position
	pass
