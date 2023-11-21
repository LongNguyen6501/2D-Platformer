extends KinematicBody2D
onready var anim = get_node("AnimatedSprite")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HitBox_body_entered(body):
	if body.name == "Player":
		print("1")
		get_tree().change_scene("res://Main.tscn")
