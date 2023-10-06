extends KinematicBody2D


# Variables
var maxSpeed = 200

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.action_press("ui_right"):
		velocity.x += 1
	if Input.action_press("ui_left"):
		velocity.x -= 1
	if Input.action_press("ui_up"):
		velocity.y += 1
	if Input.action_press("ui_down"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * maxSpeed
		
	move_and_slide(velocity)

	
	#Jump
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
