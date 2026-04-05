extends Area2D

@onready var timer: Timer = $Timer
@onready var mesh_instance_2d = $MeshInstance2D
@onready var label = $Control/MarginContainer/Label
@onready var pickup_audio = $PickupAudio
@onready var interact_audio = $InteractAudio

var player_node : Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	Global.CMD_QUEUE.append([0])
	Global.SUBMIT_QUEUE.append([10])
	timer.set_wait_time(Global.GAMERULE.COMMAND_SPAWN_TIME)
	timer.start()
	mesh_instance_2d.modulate = Color.WHITE

func _process(delta):
	label.text = ""
	if len(Global.CMD_QUEUE) < 2:
		for command in Global.CMD_QUEUE:
			var parts = []
			for arg in command:
				var text = Global.COMPONENT.MAP[arg]
				var color = Global.COMPONENT.COLORS[arg]
				parts.append("[b][color=%s]%s[/color][/b]" % [color, text])
			if label.text:
				label.text = " ".join(parts) + "\n" + label.text
			else:
				label.text = " ".join(parts)
	else:
		for i in range(1):
			var parts = []
			for arg in Global.CMD_QUEUE[i]:
				var text = Global.COMPONENT.MAP[arg]
				var color = Global.COMPONENT.COLORS[arg]
				parts.append("[b][color=%s]%s[/color][/b]" % [color, text])
			if label.text:
				label.text = " ".join(parts) + "\n" + label.text
			else:
				label.text = " ".join(parts)
		label.text = str(len(Global.CMD_QUEUE)-1) + " more\n" + label.text
	_handle_player_interact()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = body

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = null

func _handle_player_interact():
	if player_node and player_node.carrying_index == -1 and len(Global.CMD_QUEUE) > 0:
		if Input.is_action_just_pressed("interact"):
			pickup_audio.play()
			var first_cmd = Global.CMD_QUEUE[0]
			var chosen_idx = randi_range(0,len(first_cmd)-1)
			var chosen_component = first_cmd.pop_at(chosen_idx)
			player_node.carrying_index = chosen_component
		if Global.CMD_QUEUE[0].is_empty():
			Global.CMD_QUEUE.pop_front()

func _on_timer_timeout():
	var new_command = []
	for i in range(Global.GAMERULE.max_command_length):
		new_command.append(randi_range(1, Global.COMPONENT.NUM_TYPES))
	new_command.sort()
	var unique_command = []
	var submit_command = []
	for value in new_command:
		if unique_command.is_empty() or unique_command[-1] != value:
			unique_command.append(value)
			submit_command.append(value + 10)
	Global.CMD_QUEUE.append(unique_command)
	Global.SUBMIT_QUEUE.append(submit_command)
	pickup_audio.play()
