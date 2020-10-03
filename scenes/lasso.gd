extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Chnage damp (1 for speedy, 2 for slow)

var scale_speed = 0.5
onready var area2d_node = get_node("Area2D")
onready var sprite_node = get_node("Sprite")

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
		
		
	print(self.linear_velocity)
