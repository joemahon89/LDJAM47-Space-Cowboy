extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Chnage damp (1 for speedy, 2 for slow)
var direction = Vector2(0,0)
var scale_speed = 0.5
var inside_lasso = []
onready var area2d_node = get_node("Area2D")
onready var sprite_node = get_node("lasso_sprite")

onready var rope_node = get_node("lasso_rope")
onready var rope_anchor_point_node = get_tree().get_root().get_node("Node2D/lasso_anchor_point")
onready var rope_join_point_node = get_node("lasso_sprite/lasso_join_point")

onready var main_node = get_tree().get_root().get_node("Node2D")
#onready var lasso_anchor_point_node = get_node("lasso_anchor_point")




onready var animation_easy = get_node("animationplayer_easy")


var input_allowed = true
var start_delay_timer = Timer.new()
var start_delay = 0.1
var reset_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_lasso_scale(Vector2(0.5, 0.5))
	
	start_delay_timer.set_one_shot(true)
	start_delay_timer.set_wait_time(start_delay)
	start_delay_timer.connect("timeout", self, "_on_start_delay_timer_timeout")
	add_child(start_delay_timer)
	# Enable if want autostart
	#start_delay_timer.start()
	input_allowed = false
	pass


func pre_reset_lasso():
	#if reset_pressed == true:
	#animation_easy.seek(0.0,true)
	animation_easy.stop(true)
		
	#start_delay_timer.stop()
	#set_applied_force(Vector2(0,0))
	#linear_velocity = Vector2(0,0)
	#applied_force = Vector2(0,0)
		
	#xform.origin.x = 320
	#xform.origin.y = 330
		
	reset_pressed = false
	#reset_lasso()
	
	start_delay_timer.start()


func reset_lasso():
	set_mode(3)
	#animation_easy.clear_caches()
	#animation_easy.stop()
	#print("PLAYING")
	#print(animation_easy.is_playing())
	#print("YAY OR NAY")
	position = Vector2(320,330)
	set_lasso_scale(Vector2(0.5, 0.5))
	set_mode(0)
	initial_impulse()

#	print("timer started")
	#start_delay_timer.stop()
	#start_delay_timer = Timer.new()
	
	#print("pos",position)
	
	position = Vector2(320,330)
	#input_allowed = false
	#set_lasso_scale(Vector2(0.5, 0.5))
	#initial_impulse()
	#print("resetting")
	#input_allowed = true
	#start_delay_timer.set_wait_time(start_delay)
	#start_delay_timer.connect("timeout", self, "_on_start_delay_timer_timeout")
	#start_delay_timer.start()
	
func _on_start_delay_timer_timeout():
	start_delay_timer.stop()
	input_allowed = true
	
	reset_lasso()
	animation_easy.play("lasso_scale_anim")
	


func _integrate_forces(state):
	
	if reset_pressed == true:
		if global.current_captured:
			global.current_captured.captured = false
			global.current_captured = null
		input_allowed = false
		print(reset_pressed)
		animation_easy.seek(0.0,true)
		animation_easy.stop(true)
		
		start_delay_timer.stop()
		set_applied_force(Vector2(0,0))
		linear_velocity = Vector2(0,0)
		var xform = state.get_transform()
		#applied_force = Vector2(0,0)
		
		xform.origin.x = 320
		xform.origin.y = 330
		
		reset_pressed = false
		#reset_lasso()
		start_delay_timer.start()
		state.set_transform(xform)



func set_lasso_scale(scale):
	area2d_node.scale.x = scale.x
	area2d_node.scale.y = scale.y
	sprite_node.scale.x = scale.x
	sprite_node.scale.y = scale.y



func shrink_lasso(delta):
	area2d_node.scale.x -= scale_speed * delta
	area2d_node.scale.y -= (scale_speed/2) * delta
	sprite_node.scale.x -= scale_speed * delta
	sprite_node.scale.y -= scale_speed * delta
	rope_node.width = 3 * sprite_node.scale.x

func grow_lasso(delta):
	area2d_node.scale.x += scale_speed * delta
	area2d_node.scale.y += (scale_speed/2) * delta
	sprite_node.scale.x += scale_speed * delta
	sprite_node.scale.y += scale_speed * delta
	rope_node.width = 3 * sprite_node.scale.x


func initial_impulse():
	# Old random impulse dir
#	randomize()
#	var angle_x = (randi() % (10 - 2) + 2)*0.1*-1
#	randomize()
#	var angle_y = (randi() % (10 - 2) + 2)*0.1*-1
#	var angle_vector = Vector2(angle_x, angle_y)
	#apply_impulse(Vector2(), angle_vector * 300)
	
	# New choose from list impuse options
	var impulse_options = [Vector2(-0.5,-0.5),
						   Vector2(-0.3,-0.7),
							Vector2(-0.6,-0.3),
							]
	var impulse_strengths = [300, 400, 500]
	randomize()
	var impulse_option = impulse_options[randi() % impulse_options.size()]
	randomize()
	var impulse_strength = impulse_strengths[randi() % impulse_strengths.size()]
	
	apply_impulse(Vector2(), impulse_option * impulse_strength)
	
	
func _unhandled_input(event):
	if event.is_action_pressed("lasso_cast"):
		reset_pressed = true
		#reset_lasso()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if input_allowed == true:
		
		if Input.is_action_pressed("lasso_up"):
			# Tryiong to go too far up, push back down
			if position.y <= main_node.spawn_area_y_min:
				direction = Vector2(0,1)
			else:
				direction = Vector2(0,-1)
			apply_impulse(Vector2(), direction * 2)
			
		if Input.is_action_pressed("lasso_down"):
			# Tryiong to go too far down, push back up
			if position.y >= main_node.spawn_area_y_max+20:
				direction = Vector2(0,-1)			
			else:
				direction = Vector2(0,1)
			apply_impulse(Vector2(), direction * 2)
			
			
		if Input.is_action_pressed("lasso_left"):
			# Tryiong to go too far left, push back right
			if position.x <= main_node.spawn_area_x_min:
				direction = Vector2(1,0)
			else:
				direction = Vector2(-1,0)
			apply_impulse(Vector2(), direction * 2)
			
		if Input.is_action_pressed("lasso_right"):
			# Tryiong to go too far right, push back right
			if position.x >= main_node.spawn_area_x_max:
				direction = Vector2(-1,0)
			else:
				direction = Vector2(1,0)
			apply_impulse(Vector2(), direction * 2)
			
		#if direction != Vector2(0,0):
			
			
		
		if Input.is_action_pressed("lasso_shrink"):
			shrink_lasso(delta)
		if Input.is_action_pressed("lasso_grow"):
			shrink_lasso(delta)
		
		
	#print(self.linear_velocity)

	#lasso_rope_node.points = [Vector2(0,0), Vector2(0,0)]
	rope_node.points[0] = rope_anchor_point_node.get_global_position() - self.get_global_position()
	rope_node.points[1] = rope_join_point_node.get_global_position() - self.get_global_position()
	rope_node.width = 3 * sprite_node.scale.x
	#lasso_rope_node.points[1] = lasso_join_point_node.position + lasso_node.position

# Moving onto an animal
func _on_Area2D_area_entered(area):
	inside_lasso.append(area)
	#print("IN", inside_lasso)
	
	var label_01 = get_tree().get_root().get_node("Node2D/Container/label_01")
	if label_01:
		label_01.text = ""
		for creature in inside_lasso:
			label_01.text = label_01.text + creature.get_name() + ","
# Moving off an animal
func _on_Area2D_area_exited(area):
	inside_lasso.remove(inside_lasso.find(area))
	#print("IN", inside_lasso)
	
	var label_01 = get_tree().get_root().get_node("Node2D/Container/label_01")
	label_01.text = ""
	if label_01:
		for creature in inside_lasso:
			label_01.text = label_01.text + creature.get_name() + ","





# Has a creature been caught?
func check_if_creature_caught():
	if len(inside_lasso) > 0:
		creature_captured(true, inside_lasso[0])
	else:
		creature_captured(false, null)

		
		
		
func creature_captured(captured, creature):
	#print(creature)
	if captured:
		var creature_node = creature.get_node("..")
		creature_node.get_node("particles_captured").emitting = true
		creature_node.move_after_capture()
		global.current_captured = creature_node
		#reset_pressed = true
	else:
		reset_pressed = true
		#start_delay_timer.start()
		#pre_reset_lasso()
		pass
		# Destroy the lasso or make it go back to start?
		

func _on_animationplayer_easy_animation_finished(anim_name):
	check_if_creature_caught()

