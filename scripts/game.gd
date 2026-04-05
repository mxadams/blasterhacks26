extends Node

@onready var timer: Timer = $Timer
@onready var label_left = $Control/MarginContainer/HBoxContainer/LabelLeft
@onready var label_right = $Control/MarginContainer/HBoxContainer/LabelRight
@onready var speed_display_digits: int = 3

var speed_display_factor: float = pow(10.0,speed_display_digits)

func _ready():
	randomize()
	timer.set_wait_time(Global.GAMERULE.DIFFICULTY_INCREASE_TIME)
	timer.start()

func _process(delta):
	#label_left.text = "Difficulty: " + str(Global.GAMERULE.difficulty_level) + "\n"
	label_left.text = "Score: " + str(Global.GAMERULE.score)
	label_right.text = "Welcome to the world's first modular, AI-first operating system"
	label_right.text += "\nYou are the agent that routes terminal command components from the parsing agent to the handler agents"
	label_right.text += "\nNo it isn't overengineered"
	label_right.text += "\nKeep the queue of waiting commands below " + str(Global.GAMERULE.MAX_SUBMIT_LEN) + ", Arrow keys to move, Space to interact"
	if len(Global.SUBMIT_QUEUE) > Global.GAMERULE.MAX_SUBMIT_LEN:
		print("GAME OVER")

func _on_timer_timeout():
	Global.GAMERULE.difficulty_level += 1
	Global.PLAYER.move_speed += Global.GAMERULE.PLAYER_SPEED_INCREASE
	if Global.GAMERULE.difficulty_level > 1 and (Global.GAMERULE.difficulty_level & (Global.GAMERULE.difficulty_level - 1)) == 0:
		Global.GAMERULE.max_command_length += 1
