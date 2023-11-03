extends Node2D


onready var timer = get_node("JumpTimerR")

func start_jump(dur):
	timer.wait_time = dur
	timer.start()

func is_jumping():
	return !timer.is_stopped()
