extends CharacterBody2D

@onready var label: Label = $Label

var input_direction := Vector2.ZERO

var carrying_index: int = -1

func _process(delta):
	label.text = Global.COMPONENT.MAP[carrying_index]
	#carrying_index = -1

func _physics_process(delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * Global.PLAYER.move_speed * delta
	move_and_slide()
