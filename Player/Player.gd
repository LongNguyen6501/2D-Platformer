extends KinematicBody2D
#declare variable
var speed = 200
var face = 1
var jump_speed = -800
var gravity = 4000
var velocity = Vector2.ZERO
var dash_speed = 3000

func _physics_process(delta):
	#player idle velocity =0
	velocity.x = 0
	#go left and right
	if Input.is_action_pressed("ui_right"):
		face = 1
		velocity.x += speed * face
	if Input.is_action_pressed("ui_left"):
		face = -1
		velocity.x += speed * face
	#dash mechanism
	if Input.is_action_just_pressed("ui_dash"):
		velocity.x += dash_speed * face
	#player gravity code
	velocity.y += gravity * delta
	#allows player movements
	velocity = move_and_slide(velocity, Vector2.UP)
	#jump mechaninism
	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			velocity.y = jump_speed
	
