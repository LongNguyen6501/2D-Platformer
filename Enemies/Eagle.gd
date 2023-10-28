extends KinematicBody2D
var velocity = Vector2.ZERO
var player
var speed = 50
var chase = false
onready var anim = get_node("AnimatedSprite")
onready var hitBox = get_node("Death")
onready var physicsBody = get_node("Body")

func _ready():
	anim.play("Fly")

func _physics_process(delta):
	if chase == true and anim.animation != "Death":
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			anim.flip_h = true
		else: 
			anim.flip_h = false
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_PlayerDetection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_PlayerDetection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_Death_body_entered(body):
	if body.name == "Player" and anim.animation != "Death":
		body.HP -= 2
		body.anim.play("Hurt")
		body.velocity.y -= 200
		Death()

func _on_Death_area_entered(area):
	if area.name == "SwordHitBox":
		Death()

func Death():
	remove_child(hitBox)
	hitBox.queue_free()
	remove_child(physicsBody)
	physicsBody.queue_free()
	chase = false
	velocity.x = 0
	velocity.y = 0
	anim.play("Death")
	yield(get_tree().create_timer(1.0), "timeout")
	self.queue_free()
