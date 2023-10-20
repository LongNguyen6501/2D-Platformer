extends KinematicBody2D
#declare variable
var speed = 100
var jump_speed = -300
var gravity = 1000
var velocity = Vector2.ZERO
var dash_speed = 4000
var face = 1
onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	var currentAnim = anim.get_current_animation()

	#player gravity code
	if not is_on_floor():
		velocity.y += gravity * delta
	if velocity.y > 0  and currentAnim != "Run" and currentAnim != "Dash" and currentAnim != "Attack1" and currentAnim != "Idle":
		anim.play("Fall")

	#player idle velocity =0
	velocity.x = 0

	#jump
	if is_on_floor() or currentAnim == "Run" or currentAnim == "Idle":
		if Input.is_action_just_pressed("ui_jump"):
			velocity.y = jump_speed
			anim.play("Jump")

	#attack
	if Input.is_action_just_pressed("ui_attack"):
		anim.play("Attack1")

	#dash
	elif Input.is_action_just_pressed("ui_dash"):
		velocity.x += dash_speed * face
		anim.play("Dash")

	#go left and right
	elif Input.is_action_pressed("ui_right"):
		face = 1
		velocity.x += speed * face
		if is_on_floor() and velocity.y == 0 and velocity.x != 0 and currentAnim != "Attack1" and currentAnim != "Dash" and currentAnim != "Jump":
			anim.play("Run")
	elif Input.is_action_pressed("ui_left"):
		face = -1
		velocity.x += speed * face
		if is_on_floor() and velocity.y == 0 and velocity.x != 0 and currentAnim != "Attack1" and currentAnim != "Dash" and currentAnim != "Jump":
			anim.play("Run")

	#idle
	elif velocity.x == 0 and velocity.y == 0 and currentAnim != "Attack1" and currentAnim != "Dash":
		anim.play("Idle")

	#Flip sprite
	if face < 0:
		$AnimatedSprite.flip_h = true
	elif face > 0:
		$AnimatedSprite.flip_h = false

	#allows player movements
	velocity = move_and_slide(velocity, Vector2.UP)

	#debug printing 
	print(velocity.x, ",", velocity.y)
