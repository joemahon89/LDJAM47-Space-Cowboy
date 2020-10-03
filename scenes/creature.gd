extends KinematicBody2D



onready var main_node = get_tree().get_root().get_node("Node2D")
onready var cmp01 = main_node.get_node("creature_move_point_01")
onready var cmp02 = main_node.get_node("creature_move_point_02")

# Get the centre of the lasso so can follow it
onready var lasso_collider = main_node.get_node("YSort/lasso")
# Get the centre of the creature area2d so can subtract from creature pos,
# thismeans can centre lasso on the head
onready var creature_area2d = get_node("Area2D")
onready var sprite = get_node("Sprite")

export var captured_speed = 200
var captured = false

var target = Vector2()
var velocity = Vector2()



var creature_type = "creature_02"

var creature_data = {
					"creature_01": {
									"png": "res://sprites/creature_01.png",
									"sprite_offsets": Vector2(16,6),
									"move_speed": 20,
									"capture_points": 50,
									},
					"creature_02": {
									"png": "res://sprites/creature_02.png",
									"sprite_offsets": Vector2(-3,10),
									"move_speed": 50,
									"capture_points": 100,
									}
					}
						



# Called when the node enters the scene tree for the first time.
func _ready():
	# Set up creature based on sprite etc
	var creature_png = creature_data[creature_type]["png"]
	print(creature_png)
	#var creature_texture = preload("res://sprites/creature_01.png")
	var creature_texture = load(creature_png)
	sprite.set_texture(creature_texture)
	sprite.position = creature_data[creature_type]["sprite_offsets"]
	
	
	
	main_node = get_node("")
	pass # Replace with function body.


func move_before_capture():
	captured = false



func move_after_capture():
	captured = true
	target = true
	
	

func _process(delta):
	if captured:
		if target:
			target = lasso_collider.global_position
			var neck_pos = creature_area2d.global_position
			velocity = neck_pos.direction_to(target) * captured_speed
			# look_at(target)
			if neck_pos.distance_to(target) > 2:
				velocity = move_and_slide(velocity)
