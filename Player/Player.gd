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
	var currentAnim = anim.get_current_animation()
	#player gravity code
	if not is_on_floor() and currentAnim != "Run":
		velocity.y += gravity * delta

	#player idle velocity =0
	velocity.x = 0

	#jump
	if is_on_floor() or currentAnim == "Run":
		if Input.is_action_just_pressed("ui_jump"):
			velocity.y = jump_speed
			anim.play("Jump")

	#attack
	if Input.is_action_just_pressed("ui_attack"):
		attacking = 1
		anim.play("Attack1")
	elif Input.is_action_just_released("ui_attack"):
		attacking = -1
	#dash
	elif Input.is_action_just_pressed("ui_dash"):
		dashing = 1
		velocity.x += dash_speed * face
		anim.play("Dash")
	elif Input.is_action_just_released("ui_dash"):
		dashing = -1

	#go left and right
	elif Input.is_action_pressed("ui_right"):
		face = 1
		velocity.x += speed * face
		if is_on_floor() and velocity.x != 0 and attacking == -1 and dashing == -1:
			anim.play("Run")
	elif Input.is_action_pressed("ui_left"):
		face = -1
		velocity.x += speed * face
		if is_on_floor() and velocity.x != 0 and attacking == -1 and dashing == -1:
			anim.play("Run")
	#idle
	elif velocity.x == 0 and velocity.y ==0 and attacking == -1 and dashing == -1:
		anim.play("Idle")

	#Flip sprite
	if face < 0:
		$AnimatedSprite.flip_h = true
	elif face > 0:
		$AnimatedSprite.flip_h = false

#debug printing 
	print(velocity.x, ",", velocity.y)

	#allows player movements
	velocity = move_and_slide(velocity, Vector2.UP)

	
