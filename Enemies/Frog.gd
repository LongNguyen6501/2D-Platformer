extends KinematicBody2D
var velocity = Vector2.ZERO
var gravity = 1000
var player
var chase = false
var speed = 50
onready var anim = get_node("AnimatedSprite")
onready var frogBody = get_node("Death")

func _ready():
	anim.play("Idle")
func _physics_process(delta):
	#frog gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	if chase == true and anim.animation != "Death":
		anim.play("Jump")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			anim.flip_h = true
		else: 
			anim.flip_h = false
		velocity.x = direction.x * speed
	elif anim.animation != "Death":
		anim.play("Idle")
		velocity.x = 0
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_PlayerDetection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_PlayerDetection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_Death_body_entered(body):
	if body.name == "Player" and anim.animation != "Death":
		body.HP -= 1
		body.anim.play("Hurt")
		body.velocity.y -= 200
		Death()
		
func _on_Death_area_entered(area):
	if area.name == "SwordHitBox":
		Death()

func Death():
	remove_child(frogBody)
	frogBody.queue_free()
	chase = false
	velocity.x = 0
	anim.play("Death")
	yield(get_tree().create_timer(1.0), "timeout")
	self.queue_free()


