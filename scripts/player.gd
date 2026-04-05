extends CharacterBody2D

@onready var label = $Control/PanelContainer/Label
@onready var mesh_instance_2d = $MeshInstance2D

var input_direction := Vector2.ZERO

var carrying_index: int = Global.COMPONENT.NULL_INDEX

func _ready():
	mesh_instance_2d.modulate = Color.WHITE

func _process(delta):
	var text = Global.COMPONENT.MAP[carrying_index]
	var color = Global.COMPONENT.COLORS[carrying_index % 10]
	label.text = "[b][color=%s]%s[/color][/b]" % [color, text]

func _physics_process(delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * Global.PLAYER.move_speed * delta
	move_and_slide()
