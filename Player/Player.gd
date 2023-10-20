extends KinematicBody2D
#declare variable
var speed = 300
var jump_speed = -1000
var gravity = 4000
var velocity = Vector2.ZERO
var dash_speed = 6000
var face = 1
var attacking = -1
var dashing = -1
onready var anim = get_node("AnimationPlayer")
func _physics_process(delta):
	#player gravity code
	if not is_on_floor():
		velocity.y += gravity * delta
	#player idle velocity =0
	velocity.x = 0
	attacking = -1
	dashing = -1
		#jump mechaninism
	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			velocity.y = jump_speed
			anim.play("Jump")
	elif Input.is_action_just_pressed("ui_attack"):
		attacking = 1
		anim.play("Attack1")
	#go left and right
	elif Input.is_action_pressed("ui_right"):
		face = 1
		velocity.x += speed * face
		if is_on_floor() and attacking != 1 and dashing != 1:
			anim.play("Run")
	elif Input.is_action_pressed("ui_left"):
		face = -1
		velocity.x += speed * face
		if is_on_floor() and attacking != 1 and dashing != 1:
			anim.play("Run")

	#dash mechanism
	elif Input.is_action_just_pressed("ui_dash"):
		dashing = 1
		velocity.x += dash_speed * face
		anim.play("Dash")
	#attack mechanism

	elif is_on_floor() and attacking != 1 and dashing != 1:
		anim.play("Idle")
	if face < 0:
		$AnimatedSprite.flip_h = true
	elif face > 0:
		$AnimatedSprite.flip_h = false 

	#allows player movements
	velocity = move_and_slide(velocity, Vector2.UP)

	
