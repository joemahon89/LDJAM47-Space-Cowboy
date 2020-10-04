extends KinematicBody2D



onready var main_node = get_tree().get_root().get_node("Node2D")
onready var cmp01 = main_node.get_node("creature_move_point_01")
onready var cmp02 = main_node.get_node("creature_move_point_02")
onready var cmp03 = main_node.get_node("creature_move_point_03")

# Get the centre of the lasso so can follow it
onready var lasso_collider = main_node.get_node("YSort/lasso")
# Get the centre of the creature area2d so can subtract from creature pos,
# thismeans can centre lasso on the head
onready var creature_area2d = get_node("Area2D")
onready var sprite = get_node("Sprite")
onready var body_centre = get_node("body_centre")
# SPeed when captured (following lasso)
export var captured_speed = 200
# Speed when moving on own
var move_speed = 1
var captured = false
var waiting = false
var conveyoring = false
var conveyor_speed = 30

var target = Vector2()
var velocity = Vector2()

var wait_timer

var creature_type = "creature_02"

var creature_data = {
					"creature_01": {
									"png": "res://sprites/creature_01.png",
									"name": "FLUMBER",
									"sprite_offsets": Vector2(16,6),
									"body_centre": Vector2(10,10),
									"move_speed": 20,
									"capture_points": 50,
									"wait_after_move": [2,4],
									},
					"creature_02": {
									"png": "res://sprites/creature_02.png",
									"name": "PIKKA",
									"sprite_offsets": Vector2(-3,10),
									"body_centre": Vector2(0,8),
									"move_speed": 50,
									"capture_points": 100,
									"wait_after_move": [0,1],
									},
					"creature_03": {
									"png": "res://sprites/creature_03.png",
									"name": "SPACE CRAB",
									"sprite_offsets": Vector2(2,-1),
									"body_centre": Vector2(2,-1),
									"move_speed": 30,
									"capture_points": 100,
									"wait_after_move": [0,1],
									},
					"creature_04": {
									"png": "res://sprites/creature_04.png",
									"name": "BLUBBERBOB",
									"sprite_offsets": Vector2(16,7),
									"body_centre": Vector2(12,13),
									"move_speed": 10,
									"capture_points": 100,
									"wait_after_move": [3,4],
									},
					"creature_05": {
									"png": "res://sprites/creature_05.png",
									"name": "GROGSNIPPER",
									"sprite_offsets": Vector2(3,11),
									"body_centre": Vector2(0,11),
									"move_speed": 20,
									"capture_points": 100,
									"wait_after_move": [0,2],
									},
					}


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set up creature based on sprite etc
	var creature_png = creature_data[creature_type]["png"]
	#print(creature_png)
	#var creature_texture = preload("res://sprites/creature_01.png")
	var creature_texture = load(creature_png)
	sprite.set_texture(creature_texture)
	sprite.position = creature_data[creature_type]["sprite_offsets"]
	body_centre.position = creature_data[creature_type]["body_centre"]
	wait_timer = Timer.new()
	move_speed = creature_data[creature_type]["move_speed"]
	
	# Set the creatures moving
	set_new_target()
	pass # Replace with function body.


func move_before_capture():
	captured = false
	# Get a random point to move to
	set_new_target()
	if creature_type == "creature_05":
		get_node("Area2D/CollisionShape2D").scale = Vector2(0.75,0.75)


func wait_before_move_again(wait_time):
	waiting = true
	if wait_time > 0:
		wait_timer.set_wait_time(wait_time)
		wait_timer.connect("timeout", self, "_wait_timer_timeout")
		#print("timer started")
		add_child(wait_timer)
		wait_timer.start()
	# If wait time is zero, get a new target immediately
	# Only set a new target if there isnt one yet - may have been captured while stood still
	else:
		if !target:
			set_new_target()
	
func _wait_timer_timeout():
	wait_timer.stop()
	set_new_target()
	

	
		


func set_new_target():
	waiting = false
	target = Vector2(
					(randi() % (main_node.spawn_area_x_max - main_node.spawn_area_x_min) + main_node.spawn_area_x_min),
					(randi() % (main_node.spawn_area_y_max - main_node.spawn_area_y_min) + main_node.spawn_area_y_min)
					)



func move_after_capture():
	captured = true
	target = true
	# set grogsnipper to be freed by friends if close enough
	if creature_type == "creature_05":
		get_node("Area2D/CollisionShape2D").scale = Vector2(1.4,1.4)
	
#func handle_conveyorbelts():
	#target = 
#	pass
	

func _process(_delta):
	# Follow the lasso
	if captured == true:
		if target:
			target = lasso_collider.global_position
			var neck_pos = creature_area2d.global_position
			velocity = neck_pos.direction_to(target) * captured_speed
			# look_at(target)
			if neck_pos.distance_to(target) > 2:
				velocity = move_and_slide(velocity)
			if neck_pos.distance_to(cmp01.position) <= 20:
				velocity = move_and_slide(Vector2(0,0))
				AudioStreamManager.play("res://sounds/deposit_at_target.wav")
				captured = false
				conveyoring = true
				target = cmp01.position
				main_node.lasso_node.reset_pressed = true
				#handle_conveyorbelts()
				
	# Follow random points
	if captured == false:
		if waiting == false:
			if target:
				var neck_pos = creature_area2d.global_position
				velocity = neck_pos.direction_to(target) * move_speed
				# look_at(target)
				if neck_pos.distance_to(target) > 2:
					velocity = move_and_slide(velocity)
				else:
					target = null
					# How long to wait?
					var wait_min = creature_data[creature_type]["wait_after_move"][0]
					var wait_max = creature_data[creature_type]["wait_after_move"][1]
					
					var wait_length_before_move = (randi() % (wait_max - wait_min) + wait_min)
					wait_before_move_again(wait_length_before_move)
				
	# Follow conveyor belt points
	if conveyoring == true:
		var neck_pos = creature_area2d.global_position
		
		if target == cmp01.position:
			if neck_pos.distance_to(cmp01.position) < 10:
				target = cmp02.position
			else:
				velocity = neck_pos.direction_to(target) * conveyor_speed
				velocity = move_and_slide(velocity)
		if target == cmp02.position:
			if neck_pos.distance_to(cmp02.position) < 10:
				target = cmp03.position
			else:
				velocity = neck_pos.direction_to(target) * conveyor_speed
				velocity = move_and_slide(velocity)
		if target == cmp03.position:
			if neck_pos.distance_to(cmp03.position) < 10:
				global.captured_creatures.append(creature_type)
				AudioStreamManager.play("res://sounds/tunnel_received.wav")
				global.add_points(creature_data[creature_type]["capture_points"])
				
				#lasso_node
				self.queue_free()
			else:
				velocity = neck_pos.direction_to(target) * conveyor_speed
				velocity = move_and_slide(velocity)
				



func _on_Area2D_area_entered(_area):
	# for grogsnipper freeing eeach other
	if creature_type == "creature_05":

		if captured ==  true:
			AudioStreamManager.play("res://sounds/cut_lasso.wav")
			move_before_capture()
			lasso_collider.reset_pressed = true
	
	
	pass # Replace with function body.
