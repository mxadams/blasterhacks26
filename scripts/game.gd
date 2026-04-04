extends Node

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

func _ready():
	timer.set_wait_time(Global.GAMERULE.DIFFICULTY_INCREASE_TIME)
	timer.start()

func _process(delta):
	label.text = "Difficulty " + str(Global.GAMERULE.difficulty_level)
	label.text += "\nMove Speed " + str(Global.PLAYER.MOVE_SPEED)
	label.text += "\nMax Command Length " + str(Global.GAMERULE.max_command_length)

func _on_timer_timeout():
	Global.GAMERULE.difficulty_level += 1
	Global.PLAYER.MOVE_SPEED *= Global.GAMERULE.PLAYER_SPEED_INCREASE
	if Global.GAMERULE.difficulty_level > 1 and (Global.GAMERULE.difficulty_level & (Global.GAMERULE.difficulty_level - 1)) == 0:
		Global.GAMERULE.max_command_length += 1
