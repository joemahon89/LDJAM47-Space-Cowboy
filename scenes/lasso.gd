extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Chnage damp (1 for speedy, 2 for slow)

var scale_speed = 0.5
var inside_lasso = []
onready var area2d_node = get_node("Area2D")
onready var sprite_node = get_node("lasso_sprite")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_pressed("lasso_up"):
		var direction = Vector2(0,-1)
		apply_impulse(Vector2(), direction * 1)
	if Input.is_action_pressed("lasso_down"):
		var direction = Vector2(0,1)
		apply_impulse(Vector2(), direction * 1)
	if Input.is_action_pressed("lasso_left"):
		var direction = Vector2(-1,0)
		apply_impulse(Vector2(), direction * 1)
	if Input.is_action_pressed("lasso_right"):
		var direction = Vector2(1,0)
		apply_impulse(Vector2(), direction * 1)
		
	if Input.is_action_pressed("lasso_shrink"):
		area2d_node.scale.x -= scale_speed * delta
		area2d_node.scale.y -= scale_speed * delta
		sprite_node.scale.x -= scale_speed * delta
		sprite_node.scale.y -= scale_speed * delta
		
		
	if Input.is_action_pressed("lasso_grow"):
		area2d_node.scale.x += scale_speed * delta
		area2d_node.scale.y += scale_speed * delta
		sprite_node.scale.x += scale_speed * delta
		sprite_node.scale.y += scale_speed * delta
		
	#print(self.linear_velocity)




func _on_Area2D_area_entered(area):
	inside_lasso.append(area)
	print("IN", inside_lasso)
	
	var label_01 = get_tree().get_root().get_node("Node2D/Container/label_01")
	label_01.text = ""
	for creature in inside_lasso:
		label_01.text = label_01.text + creature.get_name() + ","
	

func _on_Area2D_area_exited(area):
	inside_lasso.remove(inside_lasso.find(area))
	print("IN", inside_lasso)
	
	var label_01 = get_tree().get_root().get_node("Node2D/Container/label_01")
	label_01.text = ""
	for creature in inside_lasso:
		label_01.text = label_01.text + creature.get_name() + ","
