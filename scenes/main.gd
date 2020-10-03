extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lasso_join_point_node = get_node("YSort/lasso/lasso_sprite/lasso_join_point")
onready var lasso_node = get_node("YSort/lasso")
onready var lasso_anchor_point_node = get_node("lasso_anchor_point")
onready var lasso_rope_node = get_node("lasso_rope")

var start_delay_timer
var start_delay = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	lasso_node.input_allowed = false
	OS.window_size = Vector2(720,720)
	
	start_delay_timer = Timer.new()
	start_delay_timer.set_wait_time(start_delay)
	start_delay_timer.connect("timeout", self, "_on_start_delay_timer_timeout")
	print("timer started")
	add_child(start_delay_timer)
	start_delay_timer.start()
	
func _on_start_delay_timer_timeout():
	start_delay_timer.stop()
	lasso_node.initial_impulse()
	lasso_node.input_allowed = true





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
