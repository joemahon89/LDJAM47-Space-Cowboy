extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Chnage damp (1 for speedy, 2 for slow)

var scale_speed = 0.5
var inside_lasso = []
onready var area2d_node = get_node("Area2D")
onready var sprite_node = get_node("lasso_sprite")
onready var rope_node = get_tree().get_root().get_node("Node2D/lasso_rope")


onready var animation_easy = get_node("animationplayer_easy")


var input_allowed = true
var start_delay_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_lasso_scale(Vector2(0.5, 0.5))
	pass

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
	randomize()
	var angle_x = (randi() % (10 - 2) + 2)*0.1*-1
	randomize()
	var angle_y = (randi() % (10 - 2) + 2)*0.1*-1
	print(angle_x, angle_y)
	var angle_vector = Vector2(angle_x, angle_y)
	print(angle_vector)
	apply_impulse(Vector2(), angle_vector * 300)
	animation_easy.play("lasso_scale_anim")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if input_allowed == true:

		if Input.is_action_pressed("lasso_up"):
			var direction = Vector2(0,-1)
			apply_impulse(Vector2(), direction * 2)
		if Input.is_action_pressed("lasso_down"):
			var direction = Vector2(0,1)
			apply_impulse(Vector2(), direction * 2)
		if Input.is_action_pressed("lasso_left"):
			var direction = Vector2(-1,0)
			apply_impulse(Vector2(), direction * 2)
		if Input.is_action_pressed("lasso_right"):
			var direction = Vector2(1,0)
			apply_impulse(Vector2(), direction * 2)
			
		if Input.is_action_pressed("lasso_shrink"):
			shrink_lasso(delta)
			
		if Input.is_action_pressed("lasso_grow"):
			shrink_lasso(delta)
		
		
	#print(self.linear_velocity)




func _on_Area2D_area_entered(area):
	inside_lasso.append(area)
	print("IN", inside_lasso)
	
	var label_01 = get_tree().get_root().get_node("Node2D/Container/label_01")
	if label_01:
		label_01.text = ""
		for creature in inside_lasso:
			label_01.text = label_01.text + creature.get_name() + ","
	

func _on_Area2D_area_exited(area):
	inside_lasso.remove(inside_lasso.find(area))
	print("IN", inside_lasso)
	
	var label_01 = get_tree().get_root().get_node("Node2D/Container/label_01")
	label_01.text = ""
	if label_01:
		for creature in inside_lasso:
			label_01.text = label_01.text + creature.get_name() + ","
