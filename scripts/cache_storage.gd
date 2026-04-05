extends Area2D

@onready var label = $Control/PanelContainer/Label
@onready var interact_audio = $InteractAudio

var player_node : Node = null
var carrying_index: int = -1

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta):
	if player_node and player_node.carrying_index != -1 and self.carrying_index == -1:
		var text = Global.COMPONENT.MAP[player_node.carrying_index]
		var color = Global.COMPONENT.COLORS[player_node.carrying_index % 10]
		label.text = "[b][color=%s]Cache:\nStore\n%s[/color][/b]" % [color, text]
	elif player_node and player_node.carrying_index == -1 and self.carrying_index != -1:
		var text = Global.COMPONENT.MAP[self.carrying_index]
		var color = Global.COMPONENT.COLORS[self.carrying_index % 10]
		label.text = "[b][color=%s]Cache:\nRetreive\n%s[/color][/b]" % [color, text]
	else:
		var text = Global.COMPONENT.MAP[self.carrying_index]
		var color = Global.COMPONENT.COLORS[self.carrying_index % 10]
		label.text = "[b][color=%s]Cache:\n%s[/color][/b]" % [color, text]
	_handle_player_interact()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = body

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = null

func _handle_player_interact():
	if Input.is_action_just_pressed("interact"):
		if player_node and player_node.carrying_index != -1 and self.carrying_index == -1:
			interact_audio.play()
			self.carrying_index = player_node.carrying_index
			player_node.carrying_index = -1
		elif player_node and player_node.carrying_index == -1 and self.carrying_index != -1:
			interact_audio.play()
			player_node.carrying_index = self.carrying_index
			self.carrying_index = -1
