extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Chnage damp (1 for speedy, 2 for slow)





# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(self.linear_velocity)
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
