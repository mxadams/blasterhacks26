extends Area2D

@onready var timer: Timer = $Timer
@onready var label = $Control/PanelContainer/Label

var queue = []

var player_node : Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	queue.append([0])
	timer.set_wait_time(Global.GAMERULE.COMMAND_SPAWN_TIME)
	timer.start()

func _process(delta):
	#print(timer.get_time_left())
	label.text = ""
	for command in queue:
		var command_text := " "
		for arg in command:
			command_text += Global.COMPONENT.MAP[arg] + " "
		if label.text:
			label.text = command_text + "\n" + label.text
		else:
			label.text = command_text
	#_handle_player_interact()
	pass

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = body

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = null

#func _handle_player_interact():
	#label.text = ""
	#if state == State.EMPTY:
		#if player_node and player_node.carrying_index == input_index:
			#label.text = "Deposit " + Global.COMPONENT.MAP[input_index]
			#if Input.is_action_just_pressed("interact"):
				#player_node.carrying_index = -1
				#state = State.COOKING
				#timer.start()
		#else:
			#label.text = ""
	#elif state == State.COOKING:
		#label.text = "Processing"
	#elif state == State.DONE:
		#if player_node and player_node.carrying_index == -1:
			#label.text = "Pick Up " + Global.COMPONENT.MAP[output_index]
			#if Input.is_action_just_pressed("interact"):
				#player_node.carrying_index = output_index
				#state = State.EMPTY
		#else:
			#label.text = Global.COMPONENT.MAP[output_index] + " Ready"
	#elif state == State.ERROR:
		#if player_node and player_node.carrying_index == -1:
			#label.text = "Pick Up " + Global.COMPONENT.MAP[Global.COMPONENT.ERROR_INDEX]
			#if Input.is_action_just_pressed("interact"):
				#player_node.carrying_index = Global.COMPONENT.ERROR_INDEX
				#state = State.EMPTY
		#else:
			#label.text = Global.COMPONENT.MAP[Global.COMPONENT.ERROR_INDEX] + " Ready"

func _on_timer_timeout():
	var new_command = [0]
	for i in range(Global.GAMERULE.max_command_length):
		new_command.append(randi_range(1, Global.COMPONENT.NUM_TYPES))
	new_command.sort()
	var unique_command = []
	for value in new_command:
		if unique_command.is_empty() or unique_command[-1] != value:
			unique_command.append(value)
	queue.append(unique_command)
