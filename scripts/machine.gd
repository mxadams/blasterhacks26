extends Area2D
class_name Machine

@onready var label = $Control/PanelContainer/Label
@onready var timer: Timer = $Timer

@export var input_index: int = Global.COMPONENT.NULL_INDEX
@export var output_index: int = Global.COMPONENT.NULL_INDEX
@export var cook_time: float = 4.0
@export var error_probability: float = 0.1

enum State {EMPTY, COOKING, DONE, ERROR}

var state: State = State.EMPTY

var player_node : Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	timer.set_wait_time(cook_time)

func _process(delta):
	_handle_player_interact()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = body

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_node = null

func _handle_player_interact():
	#label.text = ""
	if state == State.EMPTY:
		if player_node and player_node.carrying_index == input_index:
			label.text = "Deposit\n" + Global.COMPONENT.MAP[input_index]
			if Input.is_action_just_pressed("interact"):
				player_node.carrying_index = Global.COMPONENT.NULL_INDEX
				state = State.COOKING
				timer.start()
		else:
			label.text = ""
	elif state == State.COOKING:
		label.text = "Processing"
	elif state == State.DONE:
		if player_node and player_node.carrying_index == Global.COMPONENT.NULL_INDEX:
			label.text = "Pick Up\n" + Global.COMPONENT.MAP[output_index]
			if Input.is_action_just_pressed("interact"):
				player_node.carrying_index = output_index
				state = State.EMPTY
		else:
			label.text = Global.COMPONENT.MAP[output_index % 10] + " Ready"
	elif state == State.ERROR:
		if player_node and player_node.carrying_index == Global.COMPONENT.NULL_INDEX:
			label.text = "Pick Up\n" + Global.COMPONENT.MAP[Global.COMPONENT.ERROR_INDEX]
			if Input.is_action_just_pressed("interact"):
				player_node.carrying_index = Global.COMPONENT.ERROR_INDEX
				state = State.COOKING
				timer.start()
		else:
			label.text = Global.COMPONENT.MAP[Global.COMPONENT.ERROR_INDEX] + "\nReady"

func _on_timer_timeout():
	timer.stop()
	if randf() > error_probability:
		state = State.DONE
	else:
		state = State.ERROR
