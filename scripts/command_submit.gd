extends Area2D

@onready var label = $Control/PanelContainer/Label

var player_node : Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta):
	label.text = ""
	if len(Global.SUBMIT_QUEUE) < 2:
		for command in Global.SUBMIT_QUEUE:
			var parts = []
			for arg in command:
				var text = Global.COMPONENT.MAP[arg]
				var color = Global.COMPONENT.COLORS[arg % 10]
				parts.append("[color=%s]%s[/color]" % [color, text])
			if label.text:
				label.text += "\n" + " ".join(parts)
			else:
				label.text = " ".join(parts)
	else:
		for i in range(1):
			var parts = []
			for arg in Global.SUBMIT_QUEUE[i]:
				var text = Global.COMPONENT.MAP[arg]
				var color = Global.COMPONENT.COLORS[arg % 10]
				parts.append("[color=%s]%s[/color]" % [color, text])
			if label.text:
				label.text += "\n" + " ".join(parts)
			else:
				label.text = " ".join(parts)
		label.text += "\n" + str(len(Global.SUBMIT_QUEUE)-1) + " more"
	_handle_player_interact()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = body

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = null

func _handle_player_interact():
	if player_node and len(Global.SUBMIT_QUEUE) > 0 and player_node.carrying_index in Global.SUBMIT_QUEUE[0]:
		if Input.is_action_just_pressed("interact"):
			var first_submit = Global.SUBMIT_QUEUE[0]
			first_submit.pop_at(first_submit.find(player_node.carrying_index))
			player_node.carrying_index = -1
		if Global.SUBMIT_QUEUE[0].is_empty():
			Global.SUBMIT_QUEUE.pop_front()
			Global.GAMERULE.score += 1
