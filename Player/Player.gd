extends KinematicBody2D
#declare variable
var speed = 80
var jump_speed = -300
var gravity = 1000
var velocity = Vector2.ZERO
var dash_speed = 200
var dash_time = .4
var jump_time = .4
var face = 1
var HP = 10
onready var anim = get_node("AnimationPlayer")
onready var sword = get_node("SwordHitBox/CollisionShape2D")
onready var dash = get_node("Dash")
onready var jumpL = get_node("JumpL")
onready var jumpR = get_node("JumpR")

func _physics_process(delta):
	var currentAnim = anim.get_current_animation()
	if velocity.x == 0 and velocity.y == 0 and currentAnim != "Attack1" and currentAnim != "Dash":
		anim.play("Idle")
	#player gravity code
	if not is_on_floor() and currentAnim != "Death":
		velocity.y += gravity * delta
	if velocity.y > 99 and currentAnim != "Death" and currentAnim != "Hurt" and currentAnim != "Dash" and currentAnim != "Attack1":
		anim.play("Fall")

	#player idle velocity =0
	velocity.x = 0

	#jump
	if currentAnim == "Run" or currentAnim == "Idle":
		if Input.is_action_just_pressed("ui_jump") and currentAnim != "Hurt" and currentAnim != "Death":
			velocity.y = jump_speed
			anim.play("Jump")
		elif Input.is_action_just_pressed("ui_jump_left") and currentAnim != "Hurt" and currentAnim != "Death":
			velocity.y = jump_speed
			jumpL.start_jump(jump_time)
			anim.play("Jump")
		elif Input.is_action_just_pressed("ui_jump_right") and currentAnim != "Hurt" and currentAnim != "Death":
			velocity.y = jump_speed
			jumpR.start_jump(jump_time)
			anim.play("Jump")
	if jumpL.is_jumping():
		velocity.x = speed * -1
		face = -1
	elif jumpR.is_jumping():
		velocity.x = speed
		face = 1

	#attacks
	if Input.is_action_just_pressed("ui_attack") and currentAnim != "Hurt" and currentAnim != "Death":
		if face == 1:
			sword.position = Vector2(14, -1)
		else:
			sword.position = Vector2(-10, -1)
		anim.play("Attack1")

	#dash
	if Input.is_action_just_pressed("ui_dash") and currentAnim != "Dash" and currentAnim != "Death":
		dash.start_dash(dash_time)
		anim.play("Dash")
	if dash.is_dashing():
		velocity.x = face * dash_speed
	#run
	elif Input.is_action_pressed("ui_right") and currentAnim != "Death":
		face = 1
		velocity.x = face * speed
	elif Input.is_action_pressed("ui_left") and currentAnim != "Death":
		face = -1
		velocity.x = face * speed
	if is_on_floor() and velocity.y == 0 and velocity.x == face * speed and velocity.x != 0 and currentAnim != "Run" and currentAnim != "Attack1" and currentAnim != "Dash" and currentAnim != "Jump":
			anim.play("Run")

	#go left and right
	
	velocity = move_and_slide(velocity, Vector2.UP)
	#Flip sprite
	if face < 0:
		$AnimatedSprite.flip_h = true
	elif face > 0:
		$AnimatedSprite.flip_h = false

	#allows player movements

	
	if HP <= 0:
		velocity.x = 0
		velocity.y = 0
		anim.play("Death")
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene("res://Main.tscn")
	
	#debug printing 
	#print(velocity.x, ",", velocity.y)
