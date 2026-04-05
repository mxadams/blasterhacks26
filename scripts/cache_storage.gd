extends Area2D

@onready var label = $Control/PanelContainer/Label

var player_node : Node = null
var carrying_index: int = -1

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta):
	if player_node and player_node.carrying_index != -1 and self.carrying_index == -1:
		label.text = "Cache:\nStore " + Global.COMPONENT.MAP[player_node.carrying_index]
	elif player_node and player_node.carrying_index == -1 and self.carrying_index != -1:
		label.text = "Cache:\nRetreive " + Global.COMPONENT.MAP[self.carrying_index]
	else:
		label.text = "Cache:\n" + Global.COMPONENT.MAP[self.carrying_index]
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
			self.carrying_index = player_node.carrying_index
			player_node.carrying_index = -1
		elif player_node and player_node.carrying_index == -1 and self.carrying_index != -1:
			player_node.carrying_index = self.carrying_index
			self.carrying_index = -1
