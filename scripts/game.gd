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
	label_left.text = "Difficulty: " + str(Global.GAMERULE.difficulty_level)
	#label_left.text += "\nMove Speed " + str(Global.PLAYER.move_speed/Global.PLAYER.MOVE_SPEED_BASE)
	#label_left.text += "\nMax Command Length " + str(Global.GAMERULE.max_command_length)
	label_right.text = "Score: " + str(Global.GAMERULE.score)

func _on_timer_timeout():
	Global.GAMERULE.difficulty_level += 1
	Global.PLAYER.move_speed += Global.GAMERULE.PLAYER_SPEED_INCREASE
	if Global.GAMERULE.difficulty_level > 1 and (Global.GAMERULE.difficulty_level & (Global.GAMERULE.difficulty_level - 1)) == 0:
		Global.GAMERULE.max_command_length += 1
