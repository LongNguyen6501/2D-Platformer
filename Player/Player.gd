extends KinematicBody2D
#declare variable
var speed = 100
var jump_speed = -300
var gravity = 1000
var velocity = Vector2.ZERO
var dash_speed = 4000
var face = 1
var HP = 10
onready var anim = get_node("AnimationPlayer")
onready var sword = get_node("SwordHitBox/CollisionShape2D")

func _physics_process(delta):
	var currentAnim = anim.get_current_animation()

	#player gravity code
	if not is_on_floor():
		velocity.y += gravity * delta
	if velocity.y > 99 and currentAnim != "Hurt" and currentAnim != "Dash" and currentAnim != "Attack1":
		anim.play("Fall")

	#player idle velocity =0
	velocity.x = 0

	#jump
	if currentAnim == "Run" or currentAnim == "Idle":
		if Input.is_action_just_pressed("ui_jump") and currentAnim != "Hurt":
			velocity.y = jump_speed
			anim.play("Jump")

	#attacks
	if Input.is_action_just_pressed("ui_attack") and currentAnim != "Hurt":
		if face == 1:
			sword.position = Vector2(15, -1)
		else:
			sword.position = Vector2(-11, -1)
		anim.play("Attack1")

	#dash
	elif Input.is_action_just_pressed("ui_dash") and currentAnim != "Dash":
		velocity.x += dash_speed * face
		anim.play("Dash")

	#go left and right
	elif Input.is_action_pressed("ui_right") and currentAnim != "Hurt":
		face = 1
		velocity.x += speed * face
		if is_on_floor() and velocity.y == 0 and velocity.x != 0 and currentAnim != "Attack1" and currentAnim != "Dash" and currentAnim != "Jump":
			anim.play("Run")
	elif Input.is_action_pressed("ui_left") and currentAnim != "Hurt":
		face = -1
		velocity.x += speed * face
		if is_on_floor() and velocity.y == 0 and velocity.x != 0 and currentAnim != "Attack1" and currentAnim != "Dash" and currentAnim != "Jump":
			anim.play("Run")

	#idle
	elif velocity.x == 0 and velocity.y == 0 and currentAnim != "Attack1" and currentAnim != "Dash" and currentAnim != "Hurt":
		anim.play("Idle")

	#Flip sprite
	if face < 0:
		$AnimatedSprite.flip_h = true
	elif face > 0:
		$AnimatedSprite.flip_h = false

	#allows player movements
	velocity = move_and_slide(velocity, Vector2.UP)
	
	

	#debug printing 
	#print(velocity.x, ",", velocity.y)

