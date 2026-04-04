extends CharacterBody2D

var input_direction := Vector2.ZERO

func _physics_process(delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * Global.PLAYER.MOVE_SPEED * delta
	move_and_slide()
