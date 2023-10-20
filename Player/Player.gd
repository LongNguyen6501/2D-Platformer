extends KinematicBody2D
#declare variable
var speed = 300
var jump_speed = -1000
var gravity = 4000
var velocity = Vector2.ZERO
var dash_speed = 6000
var face = 1
onready var anim = get_node("AnimationPlayer")
func _ready():
	anim.play("Idle")
func _physics_process(delta):
	#player gravity code
	if not is_on_floor():
		velocity.y += gravity * delta
	
		#jump mechaninism
	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			velocity.y = jump_speed
			anim.play("Jump")
		if velocity.y > 0:
			anim.play("Fall")
	#player idle velocity =0
	velocity.x = 0
	#go left and right
	if Input.is_action_pressed("ui_right"):
		face = 1
		velocity.x += speed * face
		anim.play("Run")
	elif Input.is_action_pressed("ui_left"):
		face = -1
		velocity.x += speed * face
		anim.play("Run")
	else:
		anim.play("Idle")
	#dash mechanism
	if Input.is_action_just_pressed("ui_dash"):
		velocity.x += dash_speed * face
		anim.play("Dash")


	#allows player movements
	velocity = move_and_slide(velocity, Vector2.UP)

	
